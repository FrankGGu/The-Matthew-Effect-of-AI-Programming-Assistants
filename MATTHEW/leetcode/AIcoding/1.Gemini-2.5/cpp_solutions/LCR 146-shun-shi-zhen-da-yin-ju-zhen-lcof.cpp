#include <vector>

class Solution {
public:
    std::vector<int> spiralOrder(std::vector<std::vector<int>>& matrix) {
        std::vector<int> result;
        if (matrix.empty() || matrix[0].empty()) {
            return result;
        }

        int top = 0;
        int bottom = matrix.size() - 1;
        int left = 0;
        int right = matrix[0].size() - 1;

        while (top <= bottom && left <= right) {
            // Traverse from left to right along the top row
            for (int col = left; col <= right; ++col) {
                result.push_back(matrix[top][col]);
            }
            top++;

            // Traverse from top to bottom along the rightmost column
            for (int row = top; row <= bottom; ++row) {
                result.push_back(matrix[row][right]);
            }
            right--;

            // Traverse from right to left along the bottom row
            if (top <= bottom) { // Check if there's still a bottom row
                for (int col = right; col >= left; --col) {
                    result.push_back(matrix[bottom][col]);
                }
                bottom--;
            }

            // Traverse from bottom to top along the leftmost column
            if (left <= right) { // Check if there's still a left column
                for (int row = bottom; row >= top; --row) {
                    result.push_back(matrix[row][left]);
                }
                left++;
            }
        }

        return result;
    }
};