#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> luckyNumbers (vector<vector<int>>& matrix) {
        vector<int> luckyNumbers;
        int m = matrix.size(), n = matrix[0].size();

        for (int i = 0; i < m; ++i) {
            int rowMin = *min_element(matrix[i].begin(), matrix[i].end());
            bool isLucky = true;
            for (int j = 0; j < n; ++j) {
                if (matrix[i][j] == rowMin) {
                    for (int k = 0; k < m; ++k) {
                        if (matrix[k][j] > rowMin) {
                            isLucky = false;
                            break;
                        }
                    }
                    if (isLucky) {
                        luckyNumbers.push_back(rowMin);
                    }
                }
            }
        }
        return luckyNumbers;
    }
};