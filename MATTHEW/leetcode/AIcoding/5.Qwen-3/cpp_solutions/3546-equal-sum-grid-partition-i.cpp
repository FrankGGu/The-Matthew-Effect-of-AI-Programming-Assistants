#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> splitGrid(vector<vector<int>>& grid, int k) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<int>> result(rows, vector<int>(cols, 0));

        unordered_map<int, vector<pair<int, int>>> sumPositions;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                int sum = 0;
                for (int x = 0; x <= i; ++x) {
                    for (int y = 0; y <= j; ++y) {
                        sum += grid[x][y];
                    }
                }
                sumPositions[sum].push_back({i, j});
            }
        }

        int targetSum = 0;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                targetSum += grid[i][j];
            }
        }
        targetSum /= k;

        vector<pair<int, int>> positions = sumPositions[targetSum];
        if (positions.empty()) return {};

        int count = 0;
        for (auto& p : positions) {
            for (int i = 0; i <= p.first; ++i) {
                for (int j = 0; j <= p.second; ++j) {
                    result[i][j] = count + 1;
                }
            }
            ++count;
            if (count == k) break;
        }

        return result;
    }
};