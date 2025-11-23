#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> gridInterviewQuestion(vector<vector<string>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<int> result(cols, 0);

        for (int j = 0; j < cols; ++j) {
            int maxWidth = 0;
            for (int i = 0; i < rows; ++i) {
                maxWidth = max(maxWidth, static_cast<int>(grid[i][j].length()));
            }
            result[j] = maxWidth;
        }

        return result;
    }
};