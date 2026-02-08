#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> rowWithMaxOnces(vector<vector<int>>& mat) {
        int maxRow = 0;
        int maxCount = 0;
        for (int i = 0; i < mat.size(); ++i) {
            int count = 0;
            for (int j = 0; j < mat[i].size(); ++j) {
                if (mat[i][j] == 1) {
                    ++count;
                }
            }
            if (count > maxCount) {
                maxCount = count;
                maxRow = i;
            }
        }
        return {maxRow, maxCount};
    }
};