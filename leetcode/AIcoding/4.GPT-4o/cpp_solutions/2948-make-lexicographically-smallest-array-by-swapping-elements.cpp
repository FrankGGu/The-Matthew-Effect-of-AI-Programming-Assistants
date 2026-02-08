#include <vector>
#include <algorithm>
#include <unordered_map>

class Solution {
public:
    std::vector<int> smallestArrayWithSwaps(std::vector<int>& nums, std::vector<std::pair<int, int>>& pairs) {
        int n = nums.size();
        std::unordered_map<int, std::vector<int>> graph;
        for (const auto& p : pairs) {
            graph[p.first].push_back(p.second);
            graph[p.second].push_back(p.first);
        }

        std::vector<bool> visited(n, false);
        std::vector<int> result = nums;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                std::vector<int> indices;
                std::vector<int> values;

                dfs(i, graph, visited, indices, values);

                std::sort(indices.begin(), indices.end());
                std::sort(values.begin(), values.end());

                for (int j = 0; j < indices.size(); ++j) {
                    result[indices[j]] = values[j];
                }
            }
        }

        return result;
    }

private:
    void dfs(int node, std::unordered_map<int, std::vector<int>>& graph, std::vector<bool>& visited, std::vector<int>& indices, std::vector<int>& values) {
        visited[node] = true;
        indices.push_back(node);
        values.push_back(node);

        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, graph, visited, indices, values);
            }
        }
    }
};