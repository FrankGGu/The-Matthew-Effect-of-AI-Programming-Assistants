#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& mat) {
        if (mat.empty() || mat[0].empty()) return {};

        int rows = mat.size();
        int cols = mat[0].size();
        vector<int> result;
        int i = 0, j = 0;
        bool up = true;

        while (i < rows && j < cols) {
            if (up) {
                while (i >= 0 && j < cols) {
                    result.push_back(mat[i][j]);
                    i--;
                    j++;
                }
                i++;
                if (j < cols) {
                    j++;
                } else {
                    i++;
                }
            } else {
                while (i < rows && j >= 0) {
                    result.push_back(mat[i][j]);
                    i++;
                    j--;
                }
                j++;
                if (i < rows) {
                    i++;
                } else {
                    j++;
                }
            }
            up = !up;
        }

        return result;
    }
};