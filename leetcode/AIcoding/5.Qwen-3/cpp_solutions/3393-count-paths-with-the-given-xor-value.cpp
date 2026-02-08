#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPaths(vector<vector<int>>& grid, int k) {
        int rows = grid.size();
        int cols = grid[0].size();
        int result = 0;
        unordered_map<int, int> prefixCount;
        prefixCount[0] = 1;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                int currentXOR = 0;
                for (int x = i; x >= 0; --x) {
                    for (int y = j; y >= 0; --y) {
                        currentXOR ^= grid[x][y];
                        if (prefixCount.find(currentXOR ^ k) != prefixCount.end()) {
                            result += prefixCount[currentXOR ^ k];
                        }
                    }
                }
                for (int x = i; x >= 0; --x) {
                    for (int y = j; y >= 0; --y) {
                        int tempXOR = 0;
                        for (int a = x; a >= 0; --a) {
                            for (int b = y; b >= 0; --b) {
                                tempXOR ^= grid[a][b];
                                prefixCount[tempXOR]++;
                            }
                        }
                    }
                }
            }
        }

        return result;
    }
};