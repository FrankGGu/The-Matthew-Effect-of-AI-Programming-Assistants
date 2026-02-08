#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int firstCompleteIndex(vector<int>& arr, vector<vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();
        unordered_map<int, pair<int, int>> pos;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                pos[mat[i][j]] = {i, j};
            }
        }

        vector<int> rowCount(m, 0);
        vector<int> colCount(n, 0);

        for (int k = 0; k < arr.size(); ++k) {
            int val = arr[k];
            auto [i, j] = pos[val];
            rowCount[i]++;
            colCount[j]++;

            if (rowCount[i] == n || colCount[j] == m) {
                return k;
            }
        }

        return -1;
    }
};