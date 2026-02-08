#include <vector>
#include <numeric> // Not strictly necessary for this specific problem, but often useful with vector operations.

class Solution {
public:
    // This function assumes the input `data` is a 2D vector of integers,
    // and `missing_val` is the integer representing missing data.
    // It returns a new 2D vector containing only the rows from `data`
    // that do not contain `missing_val`.
    std::vector<std::vector<int>> dropMissingData(std::vector<std::vector<int>>& data, int missing_val) {
        std::vector<std::vector<int>> result;
        for (const auto& row : data) {
            bool has_missing = false;
            for (int val : row) {
                if (val == missing_val) {
                    has_missing = true;
                    break;
                }
            }
            if (!has_missing) {
                result.push_back(row);
            }
        }
        return result;
    }
};