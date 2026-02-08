#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int droneTower(vector<string>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int result = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 'D') {
                    int count = 1;
                    int x = i, y = j;

                                        while (x >= 0 && grid[x][y] == 'D') {
                        x--;
                    }
                    x++;
                    while (x < rows && grid[x][y] == 'D') {
                        count++;
                        x++;
                    }

                                        x = i;
                    while (x < rows && grid[x][y] == 'D') {
                        x++;
                    }
                    x--;
                    while (x >= 0 && grid[x][y] == 'D') {
                        count++;
                        x--;
                    }

                                        x = i;
                    y = j;
                    while (y >= 0 && grid[x][y] == 'D') {
                        y--;
                    }
                    y++;
                    while (y < cols && grid[x][y] == 'D') {
                        count++;
                        y++;
                    }

                                        y = j;
                    while (y < cols && grid[x][y] == 'D') {
                        y++;
                    }
                    y--;
                    while (y >= 0 && grid[x][y] == 'D') {
                        count++;
                        y--;
                    }

                    result = max(result, count);
                }
            }
        }

        return result;
    }
};