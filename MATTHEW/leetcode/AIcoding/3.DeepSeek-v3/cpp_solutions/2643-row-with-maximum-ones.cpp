#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> rowAndMaximumOnes(vector<vector<int>>& mat) {
        vector<int> result(2, 0);
        int max_ones = 0;
        int row_index = 0;

        for (int i = 0; i < mat.size(); ++i) {
            int count = 0;
            for (int num : mat[i]) {
                if (num == 1) {
                    count++;
                }
            }
            if (count > max_ones) {
                max_ones = count;
                row_index = i;
            } else if (count == max_ones && i < row_index) {
                row_index = i;
            }
        }

        result[0] = row_index;
        result[1] = max_ones;
        return result;
    }
};