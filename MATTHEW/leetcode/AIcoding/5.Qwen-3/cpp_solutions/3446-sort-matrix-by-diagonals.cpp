#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> diagonalSort(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();

        vector<vector<int>> result(m, vector<int>(n));

        for (int i = 0; i < m + n - 1; ++i) {
            vector<int> diag;
            int r = i < n ? 0 : i - n + 1;
            int c = i < n ? i : n - 1;
            while (r < m && c >= 0) {
                diag.push_back(mat[r][c]);
                ++r;
                --c;
            }
            sort(diag.begin(), diag.end());
            r = i < n ? 0 : i - n + 1;
            c = i < n ? i : n - 1;
            int idx = 0;
            while (r < m && c >= 0) {
                result[r][c] = diag[idx++];
                ++r;
                --c;
            }
        }

        return result;
    }
};