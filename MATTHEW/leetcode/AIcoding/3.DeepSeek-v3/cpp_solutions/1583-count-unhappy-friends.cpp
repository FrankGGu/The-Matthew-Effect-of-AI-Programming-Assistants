class Solution {
public:
    int unhappyFriends(int n, vector<vector<int>>& preferences, vector<vector<int>>& pairs) {
        vector<int> pairMap(n);
        for (auto& pair : pairs) {
            pairMap[pair[0]] = pair[1];
            pairMap[pair[1]] = pair[0];
        }

        vector<vector<int>> rank(n, vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < preferences[i].size(); ++j) {
                rank[i][preferences[i][j]] = j;
            }
        }

        int res = 0;
        for (int x = 0; x < n; ++x) {
            int y = pairMap[x];
            bool unhappy = false;
            for (int u = 0; u < n; ++u) {
                if (u == x || u == y) continue;
                int v = pairMap[u];
                if (rank[x][u] < rank[x][y] && rank[u][x] < rank[u][v]) {
                    unhappy = true;
                    break;
                }
            }
            if (unhappy) ++res;
        }
        return res;
    }
};