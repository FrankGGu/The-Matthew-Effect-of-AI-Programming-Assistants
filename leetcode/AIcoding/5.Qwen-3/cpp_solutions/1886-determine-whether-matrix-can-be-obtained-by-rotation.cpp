#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool findRotation(vector<vector<int>>& mat, vector<vector<int>>& target) {
        for (int i = 0; i < 4; ++i) {
            if (mat == target) return true;
            rotate(mat);
        }
        return false;
    }

private:
    void rotate(vector<vector<int>>& mat) {
        int n = mat.size();
        for (int i = 0; i < n / 2; ++i) {
            for (int j = i; j < n - i - 1; ++j) {
                int temp = mat[i][j];
                mat[i][j] = mat[n - j - 1][i];
                mat[n - j - 1][i] = mat[n - i - 1][n - j - 1];
                mat[n - i - 1][n - j - 1] = mat[j][n - i - 1];
                mat[j][n - i - 1] = temp;
            }
        }
    }
};