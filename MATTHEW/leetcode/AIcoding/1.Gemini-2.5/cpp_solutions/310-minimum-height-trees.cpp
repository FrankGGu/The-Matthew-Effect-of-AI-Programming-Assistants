#include <vector>
#include <queue>
#include <unordered_set>

class Solution {
public:
    std::vector<int> findMinHeightTrees(int n, std::vector<std::vector<int>>& edges) {
        if (n <= 1) {
            return n == 1 ? std::vector<int>{0} : std::vector<int>{};
        }

        std::vector<std::vector<int>> adj(n);
        std::vector<int> degrees(n, 0);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
            degrees[edge[0]]++;
            degrees[edge[1]]++;
        }

        std::queue<int> leaves;
        for (int i = 0; i < n; ++i) {
            if (degrees[i] == 1) {
                leaves.push(i);
            }
        }

        int remaining_nodes = n;
        while (remaining_nodes > 2) {
            int leaves_count = leaves.size();
            remaining_nodes -= leaves_count;
            for (int i = 0; i < leaves_count; ++i) {
                int leaf = leaves.front();
                leaves.pop();

                for (int neighbor : adj[leaf]) {
                    degrees[neighbor]--;
                    if (degrees[neighbor] == 1) {
                        leaves.push(neighbor);
                    }
                }
            }
        }

        std::vector<int> result;
        while (!leaves.empty()) {
            result.push_back(leaves.front());
            leaves.pop();
        }
        return result;
    }
};