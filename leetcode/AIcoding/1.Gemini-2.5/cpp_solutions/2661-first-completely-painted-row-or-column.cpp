#include <vector>
#include <unordered_map>
#include <utility>

class Solution {
public:
    int firstCompleteIndex(std::vector<int>& arr, std::vector<std::vector<int>>& mat) {
        int m = mat.size();
        int n = mat[0].size();

        std::vector<std::pair<int, int>> pos(m * n + 1);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                pos[mat[i][j]] = {i, j};
            }
        }

        std::vector<int> rowCount(m, 0);
        std::vector<int> colCount(n, 0);

        for (int i = 0; i < arr.size(); ++i) {
            int val = arr[i];
            auto [r, c] = pos[val];

            rowCount[r]++;
            colCount[c]++;

            if (rowCount[r] == n || colCount[c] == m) {
                return i;
            }
        }

        return -1;
    }
};