#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> numMagicSquaresInitGrid(vector<vector<int>>& grid) {
        vector<vector<int>> result;
        int rows = grid.size();
        int cols = grid[0].size();

        for (int i = 0; i <= rows - 3; ++i) {
            for (int j = 0; j <= cols - 3; ++j) {
                unordered_set<int> s;
                bool isMagic = true;

                for (int x = 0; x < 3; ++x) {
                    for (int y = 0; y < 3; ++y) {
                        int val = grid[i + x][j + y];
                        if (val < 1 || val > 9) {
                            isMagic = false;
                            break;
                        }
                        s.insert(val);
                    }
                    if (!isMagic) break;
                }

                if (!isMagic || s.size() != 9) continue;

                int sum = 0;
                for (int x = 0; x < 3; ++x) sum += grid[i + x][j + x];

                for (int x = 0; x < 3; ++x) {
                    int rowSum = 0, colSum = 0;
                    for (int y = 0; y < 3; ++y) {
                        rowSum += grid[i + x][j + y];
                        colSum += grid[i + y][j + x];
                    }
                    if (rowSum != sum || colSum != sum) {
                        isMagic = false;
                        break;
                    }
                }

                if (isMagic) {
                    result.push_back({i, j});
                }
            }
        }

        return result;
    }
};