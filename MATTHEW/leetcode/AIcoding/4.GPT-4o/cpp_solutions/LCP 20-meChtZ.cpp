class Solution {
public:
    int shortestDistance(int n, vector<vector<int>>& roads) {
        vector<vector<int>> dist(n, vector<int>(n, INT_MAX));
        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }
        for (const auto& road : roads) {
            dist[road[0]][road[1]] = min(dist[road[0]][road[1]], road[2]);
            dist[road[1]][road[0]] = min(dist[road[1]][road[0]], road[2]);
        }
        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][k] != INT_MAX && dist[k][j] != INT_MAX) {
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }
        int max_distance = 0;
        for (int i = 0; i < n; ++i) {
            if (dist[0][i] == INT_MAX) return -1;
            max_distance = max(max_distance, dist[0][i]);
        }
        return max_distance;
    }
};