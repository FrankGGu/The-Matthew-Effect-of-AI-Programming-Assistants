#include <vector>
#include <set>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> dropDuplicateRows(std::vector<std::vector<int>>& matrix) {
        std::set<std::vector<int>> uniqueRows;
        std::vector<std::vector<int>> result;

        for (const auto& row : matrix) {
            if (uniqueRows.insert(row).second) {
                result.push_back(row);
            }
        }
        return result;
    }
};