#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool checkValid(vector<vector<int>>& matrix) {
        int n = matrix.size();
        for (int i = 0; i < n; ++i) {
            unordered_set<int> row_set;
            unordered_set<int> col_set;
            for (int j = 0; j < n; ++j) {
                row_set.insert(matrix[i][j]);
                col_set.insert(matrix[j][i]);
            }
            if (row_set.size() != n || col_set.size() != n) {
                return false;
            }
        }
        return true;
    }
};