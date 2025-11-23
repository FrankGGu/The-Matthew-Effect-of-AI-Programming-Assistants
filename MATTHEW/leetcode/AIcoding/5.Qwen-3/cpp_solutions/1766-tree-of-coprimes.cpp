#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getCoprimes(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (auto& e : edges) {
            graph[e[0]].push_back(e[1]);
            graph[e[1]].push_back(e[0]);
        }

        vector<vector<int>> depth;
        vector<vector<int>> ancestors;
        vector<int> res(n, 0);

        for (int i = 0; i < n; ++i) {
            depth.push_back(vector<int>());
            ancestors.push_back(vector<int>());
        }

        vector<int> parent(n, -1);
        vector<int> depthArr(n, 0);
        vector<int> visited(n, 0);

        function<void(int)> dfs = [&](int node) {
            visited[node] = 1;
            depth[depthArr[node]].push_back(node);
            ancestors[node] = depthArr[node] > 0 ? ancestors[parent[node]] : vector<int>();
            int d = depthArr[node];
            for (int a : ancestors[node]) {
                if (__gcd(a, node) == 1) {
                    res[node] = a;
                    break;
                }
            }
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    parent[neighbor] = node;
                    depthArr[neighbor] = depthArr[node] + 1;
                    dfs(neighbor);
                }
            }
        };

        dfs(0);

        return res;
    }
};