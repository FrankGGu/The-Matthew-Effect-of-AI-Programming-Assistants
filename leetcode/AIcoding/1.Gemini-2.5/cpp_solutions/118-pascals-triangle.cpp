#include <vector>

class Solution {
public:
    std::vector<std::vector<int>> generate(int numRows) {
        std::vector<std::vector<int>> result;

        if (numRows == 0) {
            return result;
        }

        result.push_back({1});

        if (numRows == 1) {
            return result;
        }

        result.push_back({1, 1});

        for (int i = 2; i < numRows; ++i) {
            std::vector<int> currentRow(i + 1);
            currentRow[0] = 1;
            currentRow[i] = 1;

            const std::vector<int>& prevRow = result[i - 1];

            for (int j = 1; j < i; ++j) {
                currentRow[j] = prevRow[j - 1] + prevRow[j];
            }
            result.push_back(currentRow);
        }

        return result;
    }
};