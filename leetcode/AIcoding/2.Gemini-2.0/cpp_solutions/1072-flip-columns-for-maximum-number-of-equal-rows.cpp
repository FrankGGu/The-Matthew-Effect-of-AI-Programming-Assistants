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
            vector<int> key = (row[0] == 0) ? row : flippedRow;
            count[key]++;
            maxCount = max(maxCount, count[key]);
        }
        return maxCount;
    }
};