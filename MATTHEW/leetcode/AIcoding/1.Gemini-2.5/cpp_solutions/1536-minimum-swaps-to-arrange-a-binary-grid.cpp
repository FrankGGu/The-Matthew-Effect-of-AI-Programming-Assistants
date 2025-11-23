#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minSwaps(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        std::vector<int> trailing_zeros_counts(n);

        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = n - 1; j >= 0; --j) {
                if (grid[i][j] == 0) {
                    count++;
                } else {
                    break;
                }
            }
            trailing_zeros_counts[i] = count;
        }

        int total_swaps = 0;

        for (int i = 0; i < n; ++i) {
            int required_zeros = n - 1 - i;

            int found_idx = -1;
            for (int j = i; j < n; ++j) {
                if (trailing_zeros_counts[j] >= required_zeros) {
                    found_idx = j;
                    break;
                }
            }

            if (found_idx == -1) {
                return -1;
            }

            total_swaps += (found_idx - i);

            int val_to_move = trailing_zeros_counts[found_idx];
            for (int k = found_idx; k > i; --k) {
                trailing_zeros_counts[k] = trailing_zeros_counts[k-1];
            }
            trailing_zeros_counts[i] = val_to_move;
        }

        return total_swaps;
    }
};