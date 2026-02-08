#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int firstCompleteIndex(vector<int>& arr, vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();

        unordered_map<int, pair<int, int>> val_to_pos;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                val_to_pos[mat[i][j]] = {i, j};
            }
        }

        vector<int> row_count(m, 0);
        vector<int> col_count(n, 0);

        for (int i = 0; i < arr.size(); ++i) {
            int val = arr[i];
            int row = val_to_pos[val].first;
            int col = val_to_pos[val].second;

            row_count[row]++;
            col_count[col]++;

            if (row_count[row] == n || col_count[col] == m) {
                return i;
            }
        }

        return -1;
    }
};