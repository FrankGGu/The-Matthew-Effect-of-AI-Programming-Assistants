#include <vector>
#include <numeric>

class Solution {
public:
    int findChampion(int n, std::vector<std::vector<int>>& grid) {
        std::vector<int> in_degree(n, 0);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) {
                    continue;
                }
                if (grid[i][j] == 1) {
                    // Team i is stronger than team j, so team j "loses" to team i.
                    // Increment in-degree for team j.
                    in_degree[j]++;
                }
            }
        }

        int champion = -1;
        for (int i = 0; i < n; ++i) {
            if (in_degree[i] == 0) {
                // This team has not been defeated by any other team.
                // Since there is guaranteed to be exactly one champion,
                // this must be the champion.
                champion = i;
                break; // Found the champion, no need to check further.
            }
        }

        return champion;
    }
};