#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestSubmatrix(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();

        for (int i = 1; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (matrix[i][j] == 1) {
                    matrix[i][j] += matrix[i - 1][j];
                }
            }
        }

        int maxArea = 0;
        for (int i = 0; i < rows; ++i) {
            vector<int> heights = matrix[i];
            sort(heights.begin(), heights.end());
            for (int j = cols - 1; j >= 0; --j) {
                if (heights[j] == 0) break;
                maxArea = max(maxArea, heights[j] * (cols - j));
            }
        }

        return maxArea;
    }
};