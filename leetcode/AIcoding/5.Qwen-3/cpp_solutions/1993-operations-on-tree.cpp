#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int numberOfOperationsToMakeBinaryTreeWithTarget(int n, vector<vector<int>>& queries) {
        vector<int> depth(n + 1, 0);
        vector<int> parent(n + 1, 0);
        vector<vector<int>> children(n + 1);

        for (int i = 2; i <= n; ++i) {
            parent[i] = i / 2;
            children[parent[i]].push_back(i);
        }

        queue<int> q;
        for (int i = 1; i <= n; ++i) {
            if (children[i].empty()) {
                q.push(i);
                depth[i] = 1;
            }
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            if (parent[node] != 0) {
                if (depth[parent[node]] < depth[node] + 1) {
                    depth[parent[node]] = depth[node] + 1;
                    q.push(parent[node]);
                }
            }
        }

        int result = 0;
        for (auto& query : queries) {
            int u = query[0];
            int v = query[1];
            int lca = -1;
            int du = depth[u], dv = depth[v];
            while (du > dv) {
                u = parent[u];
                du--;
                result++;
            }
            while (dv > du) {
                v = parent[v];
                dv--;
                result++;
            }
            while (u != v) {
                u = parent[u];
                v = parent[v];
                result += 2;
            }
        }

        return result;
    }
};