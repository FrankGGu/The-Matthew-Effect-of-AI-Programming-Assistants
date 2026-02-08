#include <vector>

class Solution {
public:
    bool checkValid(std::vector<std::vector<int>>& matrix) {
        int n = matrix.size();

        // Check each row
        for (int r = 0; r < n; ++r) {
            std::vector<bool> seen(n + 1, false); // To track numbers from 1 to n
            for (int c = 0; c < n; ++c) {
                int num = matrix[r][c];
                if (seen[num]) {
                    return false; // Duplicate found in this row
                }
                seen[num] = true;
            }
        }

        // Check each column
        for (int c = 0; c < n; ++c) {
            std::vector<bool> seen(n + 1, false); // Reset for each column
            for (int r = 0; r < n; ++r) {
                int num = matrix[r][c];
                if (seen[num]) {
                    return false; // Duplicate found in this column
                }
                seen[num] = true;
            }
        }

        return true; // All rows and columns are valid
    }
};