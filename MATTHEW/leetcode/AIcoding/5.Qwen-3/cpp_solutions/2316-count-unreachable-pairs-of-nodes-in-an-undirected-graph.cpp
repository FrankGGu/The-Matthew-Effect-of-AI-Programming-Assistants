#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long countUnreachablePairs(vector<vector<int>>& edges, int n) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        vector<int> componentSizes;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                int size = 0;
                vector<int> stack = {i};
                visited[i] = true;
                while (!stack.empty()) {
                    int node = stack.back();
                    stack.pop_back();
                    ++size;
                    for (int neighbor : adj[node]) {
                        if (!visited[neighbor]) {
                            visited[neighbor] = true;
                            stack.push_back(neighbor);
                        }
                    }
                }
                componentSizes.push_back(size);
            }
        }

        long long result = 0;
        long long total = 0;
        for (int size : componentSizes) {
            result += static_cast<long long>(size) * total;
            total += size;
        }

        return result;
    }
};