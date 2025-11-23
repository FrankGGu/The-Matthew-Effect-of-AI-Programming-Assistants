#include <vector>
#include <numeric>

class Solution {
public:
    int unhappyFriends(int n, std::vector<std::vector<int>>& preferences, std::vector<std::vector<int>>& pairs) {
        std::vector<int> partner(n);
        for (const auto& p : pairs) {
            partner[p[0]] = p[1];
            partner[p[1]] = p[0];
        }

        std::vector<std::vector<int>> rank(n, std::vector<int>(n));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n - 1; ++j) {
                rank[i][preferences[i][j]] = j;
            }
        }

        int unhappy_count = 0;
        for (int x = 0; x < n; ++x) {
            int y = partner[x];

            for (int u_idx = 0; u_idx < rank[x][y]; ++u_idx) {
                int u = preferences[x][u_idx];
                int v = partner[u];

                if (rank[u][x] < rank[u][v]) {
                    unhappy_count++;
                    break;
                }
            }
        }

        return unhappy_count;
    }
};