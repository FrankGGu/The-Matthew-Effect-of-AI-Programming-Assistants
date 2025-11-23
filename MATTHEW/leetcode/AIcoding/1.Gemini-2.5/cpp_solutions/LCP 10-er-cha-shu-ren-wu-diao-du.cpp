#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int minimumTime(int n, vector<vector<int>>& relations, vector<int>& time) {
        vector<vector<int>> adj(n);
        vector<int> inDegree(n, 0);
        for (auto& relation : relations) {
            adj[relation[0] - 1].push_back(relation[1] - 1);
            inDegree[relation[1] - 1]++;
        }

        vector<int> maxTime(n, 0);
        vector<int> q;
        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0) {
                q.push_back(i);
                maxTime[i] = time[i];
            }
        }

        int head = 0;
        while (head < q.size()) {
            int u = q[head++];
            for (int v : adj[u]) {
                maxTime[v] = max(maxTime[v], maxTime[u] + time[v]);
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push_back(v);
                }
            }
        }

        int result = 0;
        for (int t : maxTime) {
            result = max(result, t);
        }

        return result;
    }
};