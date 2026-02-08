#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxNumberOfFamilies(vector<vector<int>>& reservedSeats) {
        unordered_map<int, vector<bool>> rowMap;
        for (const auto& seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            if (rowMap.find(row) == rowMap.end()) {
                rowMap[row] = vector<bool>(11, false);
            }
            rowMap[row][col] = true;
        }

        int count = 0;
        for (auto& [row, seats] : rowMap) {
            bool left = !seats[2] && !seats[3] && !seats[4] && !seats[5];
            bool middle = !seats[6] && !seats[7] && !seats[8] && !seats[9];
            bool right = !seats[4] && !seats[5] && !seats[6] && !seats[7];
            if (left || middle || right) {
                count += 1;
            }
        }

        return count;
    }
};