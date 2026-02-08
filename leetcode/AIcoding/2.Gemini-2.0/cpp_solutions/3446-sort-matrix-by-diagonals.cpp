#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<vector<int>> diagonalSort(vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();

        map<int, vector<int>> diagonals;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                diagonals[i - j].push_back(mat[i][j]);
            }
        }

        for (auto& [key, diag] : diagonals) {
            sort(diag.begin(), diag.end());
        }

        map<int, int> diag_index;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                mat[i][j] = diagonals[i - j][diag_index[i - j]];
                diag_index[i - j]++;
            }
        }

        return mat;
    }
};