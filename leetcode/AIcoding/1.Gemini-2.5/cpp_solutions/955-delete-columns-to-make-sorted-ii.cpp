#include <vector>
#include <string>
#include <numeric> // For std::iota if needed, but not here.

class Solution {
public:
    int minDeletionSize(std::vector<std::string>& strs) {
        int R = strs.size();
        if (R <= 1) {
            return 0;
        }
        int C = strs[0].size();
        int deleted_count = 0;

        std::vector<bool> sorted(R - 1, false);

        for (int j = 0; j < C; ++j) {
            bool must_delete_this_column = false;
            for (int i = 0; i < R - 1; ++i) {
                if (!sorted[i]) {
                    if (strs[i][j] > strs[i+1][j]) {
                        must_delete_this_column = true;
                        break;
                    }
                }
            }

            if (must_delete_this_column) {
                deleted_count++;
            } else {
                for (int i = 0; i < R - 1; ++i) {
                    if (!sorted[i]) {
                        if (strs[i][j] < strs[i+1][j]) {
                            sorted[i] = true;
                        }
                    }
                }
            }

            bool all_sorted = true;
            for (int i = 0; i < R - 1; ++i) {
                if (!sorted[i]) {
                    all_sorted = false;
                    break;
                }
            }
            if (all_sorted) {
                break; 
            }
        }

        return deleted_count;
    }
};