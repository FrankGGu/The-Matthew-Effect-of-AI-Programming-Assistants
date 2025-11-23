#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    long long C[31][31];

    void precompute_combinations() {
        for (int i = 0; i <= 30; ++i) {
            C[i][0] = 1;
            for (int j = 1; j <= i; ++j) {
                C[i][j] = C[i-1][j-1] + C[i-1][j];
            }
        }
    }

    std::string kthSmallestPath(std::vector<int>& destination, int k) {
        precompute_combinations();

        int row_needed = destination[0];
        int col_needed = destination[1];

        std::string result = "";

        while (row_needed > 0 || col_needed > 0) {
            if (col_needed > 0) {
                // Calculate number of paths if we choose 'H' next
                // Remaining: row_needed 'V's, col_needed - 1 'H's
                // Total remaining moves: row_needed + (col_needed - 1)
                // We choose row_needed positions for 'V's (or col_needed - 1 for 'H's)
                long long paths_if_H_first = C[row_needed + col_needed - 1][row_needed];

                if (k <= paths_if_H_first) {
                    result += 'H';
                    col_needed--;
                } else {
                    result += 'V';
                    k -= paths_if_H_first;
                    row_needed--;
                }
            } else {
                // Must place 'V' if no 'H's remaining
                result += 'V';
                row_needed--;
            }
        }

        return result;
    }
};