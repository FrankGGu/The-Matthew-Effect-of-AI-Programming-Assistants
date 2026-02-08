#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxNumberOfFamilies(int n, vector<vector<int>>& reservedSeats) {
        unordered_map<int, int> rows;
        for (auto& seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            if (col >= 2 && col <= 9) {
                rows[row] |= (1 << (col - 2));
            }
        }

        int count = 2 * (n - rows.size());
        for (auto& [row, reserved] : rows) {
            int possible = 0;
            if ((reserved & 0b00111100) == 0) possible++;
            if ((reserved & 0b00001111) == 0) possible++;
            if ((reserved & 0b00011110) == 0) possible--;
            count += possible;
        }

        return count;
    }
};