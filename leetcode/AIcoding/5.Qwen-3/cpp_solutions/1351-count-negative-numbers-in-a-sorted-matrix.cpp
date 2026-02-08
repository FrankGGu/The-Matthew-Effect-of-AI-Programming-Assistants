#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countNegatives(vector<vector<int>>& matrix) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int count = 0;
        int r = 0;
        int c = cols - 1;

        while (r < rows && c >= 0) {
            if (matrix[r][c] < 0) {
                count += rows - r;
                c--;
            } else {
                r++;
            }
        }

        return count;
    }
};