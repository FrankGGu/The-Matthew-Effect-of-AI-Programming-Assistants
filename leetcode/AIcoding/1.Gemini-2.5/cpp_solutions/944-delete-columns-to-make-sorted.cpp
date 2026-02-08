#include <vector>
#include <string>

class Solution {
public:
    int minDeletionSize(std::vector<std::string>& strs) {
        if (strs.empty()) {
            return 0;
        }

        int num_rows = strs.size();
        int num_cols = strs[0].length();
        int deleted_columns_count = 0;

        for (int j = 0; j < num_cols; ++j) { // Iterate through each column
            for (int i = 0; i < num_rows - 1; ++i) { // Iterate through rows to check sorting
                if (strs[i][j] > strs[i+1][j]) {
                    deleted_columns_count++;
                    break; // This column is not sorted, move to the next column
                }
            }
        }

        return deleted_columns_count;
    }
};