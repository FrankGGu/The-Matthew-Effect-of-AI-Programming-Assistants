#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int maxEqualRowsAfterFlips(vector<vector<int>>& matrix) {
        map<vector<int>, int> count;
        int maxCount = 0;
        for (auto& row : matrix) {
            vector<int> flippedRow(row.size());
            for (int i = 0; i < row.size(); ++i) {
                flippedRow[i] = 1 - row[i];
            }

            vector<int> canonicalRow;
            if(row[0] == 0){
                canonicalRow = flippedRow;
            } else {
                canonicalRow = row;
            }

            count[canonicalRow]++;
            maxCount = max(maxCount, count[canonicalRow]);
        }
        return maxCount;
    }
};