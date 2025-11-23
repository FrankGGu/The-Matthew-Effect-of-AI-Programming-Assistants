#include <vector>

using namespace std;

class Solution {
public:
    vector<int> rowAndMaximumOnes(vector<vector<int>>& mat) {
        int maxOnes = 0;
        int maxRow = -1;
        for (int i = 0; i < mat.size(); ++i) {
            int ones = 0;
            for (int j = 0; j < mat[i].size(); ++j) {
                if (mat[i][j] == 1) {
                    ones++;
                }
            }
            if (ones > maxOnes) {
                maxOnes = ones;
                maxRow = i;
            }
        }
        return {maxRow, maxOnes};
    }
};