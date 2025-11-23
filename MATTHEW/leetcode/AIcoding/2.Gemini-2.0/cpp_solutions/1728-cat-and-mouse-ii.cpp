#include <vector>

using namespace std;

class Solution {
public:
    bool canMouseWin(vector<string>& grid, int catJump, int mouseJump) {
        int rows = grid.size();
        int cols = grid[0].size();
        int mouseStartRow = -1, mouseStartCol = -1;
        int catStartRow = -1, catStartCol = -1;
        int foodRow = -1, foodCol = -1;
        int emptyCount = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 'M') {
                    mouseStartRow = i;
                    mouseStartCol = j;
                } else if (grid[i][j] == 'C') {
                    catStartRow = i;
                    catStartCol = j;
                } else if (grid[i][j] == 'F') {
                    foodRow = i;
                    foodCol = j;
                } else if (grid[i][j] == '.') {
                    emptyCount++;
                }
            }
        }

        int maxTurns = 2 * emptyCount;
        vector<vector<vector<vector<vector<int>>>>> dp(
            rows, vector<vector<vector<vector<int>>>>(
                      cols, vector<vector<vector<int>>>(
                                rows, vector<vector<int>>(cols, vector<int>(maxTurns + 1, -1)))));

        function<int(int, int, int, int, int)> solve =
            [&](int mouseRow, int mouseCol, int catRow, int catCol, int turn) {
                if (turn > maxTurns) {
                    return 0;
                }
                if (mouseRow == catRow && mouseCol == catCol) {
                    return 0;
                }
                if (mouseRow == foodRow && mouseCol == foodCol) {
                    return 1;
                }
                if (catRow == foodRow && catCol == foodCol) {
                    return 0;
                }

                if (dp[mouseRow][mouseCol][catRow][catCol][turn] != -1) {
                    return dp[mouseRow][mouseCol][catRow][catCol][turn];
                }

                int result = (turn % 2 == 0) ? 0 : 1;

                if (turn % 2 == 0) { 
                    for (int dRow = -mouseJump; dRow <= mouseJump; ++dRow) {
                        for (int dCol = -(mouseJump - abs(dRow)); dCol <= (mouseJump - abs(dRow)); ++dCol) {
                            int newMouseRow = mouseRow + dRow;
                            int newMouseCol = mouseCol + dCol;

                            if (newMouseRow >= 0 && newMouseRow < rows && newMouseCol >= 0 &&
                                newMouseCol < cols && grid[newMouseRow][newMouseCol] != '#') {
                                if (solve(newMouseRow, newMouseCol, catRow, catCol, turn + 1) == 1) {
                                    result = 1;
                                    break;
                                }
                            }
                        }
                        if(result == 1) break;
                    }
                } else {
                    for (int dRow = -catJump; dRow <= catJump; ++dRow) {
                        for (int dCol = -(catJump - abs(dRow)); dCol <= (catJump - abs(dRow)); ++dCol) {
                            int newCatRow = catRow + dRow;
                            int newCatCol = catCol + dCol;

                            if (newCatRow >= 0 && newCatRow < rows && newCatCol >= 0 &&
                                newCatCol < cols && grid[newCatRow][newCatCol] != '#') {
                                if (solve(mouseRow, mouseCol, newCatRow, newCatCol, turn + 1) == 0) {
                                    result = 0;
                                    break;
                                }
                            }
                        }
                        if(result == 0) break;
                    }
                }

                return dp[mouseRow][mouseCol][catRow][catCol][turn] = result;
            };

        return solve(mouseStartRow, mouseStartCol, catStartRow, catStartCol, 0) == 1;
    }
};