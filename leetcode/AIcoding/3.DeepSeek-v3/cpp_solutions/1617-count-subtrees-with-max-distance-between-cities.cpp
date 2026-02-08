class Solution {
public:
    vector<int> countSubgraphsForEachDiameter(int n, vector<vector<int>>& edges) {
        vector<vector<int>> dist(n, vector<int>(n, n));
        for (int i = 0; i < n; ++i) dist[i][i] = 0;
        for (const auto& e : edges) {
            int u = e[0] - 1, v = e[1] - 1;
            dist[u][v] = dist[v][u] = 1;
        }
        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }
        vector<int> res(n - 1, 0);
        for (int mask = 1; mask < (1 << n); ++mask) {
            int d = maxDistance(mask, dist, n);
            if (d > 0) ++res[d - 1];
        }
        return res;
    }

private:
    int maxDistance(int mask, const vector<vector<int>>& dist, int n) {
        int cnt = 0, max_d = 0;
        for (int i = 0; i < n; ++i) {
            if (!(mask & (1 << i))) continue;
            ++cnt;
            for (int j = i + 1; j < n; ++j) {
                if (!(mask & (1 << j))) continue;
                if (dist[i][j] == 1) ++cnt;
                max_d = max(max_d, dist[i][j]);
            }
        }
        return cnt > 0 && cnt == __builtin_popcount(mask) * (__builtin_popcount(mask) - 1) + 1 ? max_d : 0;
    }
};