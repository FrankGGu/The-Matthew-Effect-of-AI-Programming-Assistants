class Solution {
public:
    long long minimumCost(string source, string target, vector<char>& original, vector<char>& changed, vector<int>& cost) {
        const int INF = 1e9;
        vector<vector<int>> dist(26, vector<int>(26, INF));
        for (int i = 0; i < 26; ++i) {
            dist[i][i] = 0;
        }
        for (int i = 0; i < original.size(); ++i) {
            int u = original[i] - 'a';
            int v = changed[i] - 'a';
            dist[u][v] = min(dist[u][v], cost[i]);
        }
        for (int k = 0; k < 26; ++k) {
            for (int i = 0; i < 26; ++i) {
                for (int j = 0; j < 26; ++j) {
                    if (dist[i][k] + dist[k][j] < dist[i][j]) {
                        dist[i][j] = dist[i][k] + dist[k][j];
                    }
                }
            }
        }
        long long res = 0;
        for (int i = 0; i < source.size(); ++i) {
            int u = source[i] - 'a';
            int v = target[i] - 'a';
            if (dist[u][v] == INF) {
                return -1;
            }
            res += dist[u][v];
        }
        return res;
    }
};