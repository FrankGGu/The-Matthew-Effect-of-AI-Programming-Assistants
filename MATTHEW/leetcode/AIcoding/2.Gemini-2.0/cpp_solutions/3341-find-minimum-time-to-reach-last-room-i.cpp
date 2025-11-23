#include <vector>

using namespace std;

class Solution {
public:
    int firstCompleteIndex(vector<int>& arr, vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        vector<pair<int, int>> pos(m * n + 1);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                pos[mat[i][j]] = {i, j};
            }
        }

        vector<int> rowCnt(m, 0);
        vector<int> colCnt(n, 0);
        for (int i = 0; i < arr.size(); ++i) {
            int row = pos[arr[i]].first;
            int col = pos[arr[i]].second;
            rowCnt[row]++;
            colCnt[col]++;
            if (rowCnt[row] == n || colCnt[col] == m) {
                return i;
            }
        }
        return -1;
    }
};