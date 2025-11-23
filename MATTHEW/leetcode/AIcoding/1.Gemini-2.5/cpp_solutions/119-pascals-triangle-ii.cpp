#include <vector>

class Solution {
public:
    std::vector<int> getRow(int rowIndex) {
        std::vector<int> row(rowIndex + 1);
        row[0] = 1;

        for (int i = 1; i <= rowIndex; ++i) {
            row[i] = (int)((long long)row[i-1] * (rowIndex - i + 1) / i);
        }

        return row;
    }
};