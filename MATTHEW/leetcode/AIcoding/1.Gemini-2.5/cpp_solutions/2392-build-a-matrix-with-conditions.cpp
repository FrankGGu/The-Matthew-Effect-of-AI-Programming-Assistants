#include <vector>
#include <queue>
#include <unordered_map>

class Solution {
public:
    std::vector<std::vector<int>> buildMatrix(int k, std::vector<std::vector<int>>& rowConditions, std::vector<std::vector<int>>& colConditions) {
        std::vector<int> rowOrder = topologicalSort(k, rowConditions);
        std::vector<int> colOrder = topologicalSort(k, colConditions);

        if (rowOrder.empty() || colOrder.empty()) {
            return {};
        }

        std::vector<int> rowPos(k + 1);
        std::vector<int> colPos(k + 1);

        for (int i = 0; i < k; ++i) {
            rowPos[rowOrder[i]] = i;
            colPos[colOrder[i]] = i;
        }

        std::vector<std::vector<int>> matrix(k, std::vector<int>(k, 0));
        for (int i = 1; i <= k; ++i) {
            matrix[rowPos[i]][colPos[i]] = i;
        }

        return matrix;
    }

private:
    std::vector<int> topologicalSort(int k, const std::vector<std::vector<int>>& conditions) {
        std::vector<std::vector<int>> adj(k + 1);
        std::vector<int> inDegree(k + 1, 0);

        for (const auto& cond : conditions) {
            int u = cond[0];
            int v = cond[1];
            adj[u].push_back(v);
            inDegree[v]++;
        }

        std::queue<int> q;
        for (int i = 1; i <= k; ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        std::vector<int> topoOrder;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            topoOrder.push_back(u);

            for (int v : adj[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        if (topoOrder.size() == k) {
            return topoOrder;
        }

        return {};
    }
};