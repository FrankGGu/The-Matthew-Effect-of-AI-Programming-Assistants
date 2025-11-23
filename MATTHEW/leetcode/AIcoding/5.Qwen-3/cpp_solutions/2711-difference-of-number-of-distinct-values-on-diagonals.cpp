#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int differenceOfDistinctValues(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int result = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                map<int, int> leftDiag;
                map<int, int> rightDiag;

                int x = i - 1, y = j - 1;
                while (x >= 0 && y >= 0) {
                    leftDiag[grid[x][y]]++;
                    x--;
                    y--;
                }

                x = i + 1;
                y = j + 1;
                while (x < rows && y < cols) {
                    leftDiag[grid[x][y]]++;
                    x++;
                    y++;
                }

                x = i - 1;
                y = j + 1;
                while (x >= 0 && y < cols) {
                    rightDiag[grid[x][y]]++;
                    x--;
                    y++;
                }

                x = i + 1;
                y = j - 1;
                while (x < rows && y >= 0) {
                    rightDiag[grid[x][y]]++;
                    x++;
                    y--;
                }

                int leftCount = leftDiag.size();
                int rightCount = rightDiag.size();

                result += abs(leftCount - rightCount);
            }
        }

        return result;
    }
};