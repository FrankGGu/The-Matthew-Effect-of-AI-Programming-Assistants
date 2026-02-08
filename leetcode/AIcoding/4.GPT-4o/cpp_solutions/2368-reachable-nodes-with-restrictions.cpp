class Solution {
public:
    int reachableNodes(vector<vector<int>>& edges, int maxMoves, int n) {
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        priority_queue<pair<int, int>> pq;
        pq.emplace(maxMoves, 0);
        vector<int> reachable(n, 0);
        vector<int> used(n, 0);

        while (!pq.empty()) {
            auto [movesLeft, node] = pq.top();
            pq.pop();
            if (reachable[node] < movesLeft) {
                reachable[node] = movesLeft;
                for (const auto& [neighbor, cnt] : graph[node]) {
                    int newMoves = movesLeft - cnt - 1;
                    if (newMoves >= 0 && used[neighbor] < newMoves) {
                        used[neighbor] = newMoves;
                        pq.emplace(newMoves, neighbor);
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (reachable[i] >= 0) {
                result++;
            }
        }

        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1], cnt = edge[2];
            int totalUsed = min(used[u], cnt) + min(used[v], cnt);
            result += totalUsed;
        }

        return result;
    }
};