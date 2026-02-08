#include <vector>
#include <unordered_set>
using namespace std;

class Solution {
public:
    bool hasPath(vector<vector<int>>& matrix, vector<int>& path) {
        if (matrix.empty() || matrix[0].empty()) return path.empty();
        int m = matrix.size(), n = matrix[0].size();
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (dfs(matrix, path, i, j, 0)) return true;
            }
        }
        return false;
    }

private:
    bool dfs(vector<vector<int>>& matrix, vector<int>& path, int i, int j, int index) {
        if (index == path.size()) return true;
        if (i < 0 || i >= matrix.size() || j < 0 || j >= matrix[0].size() || matrix[i][j] != path[index]) return false;
        int temp = matrix[i][j];
        matrix[i][j] = -1;
        bool found = dfs(matrix, path, i + 1, j, index + 1) ||
                     dfs(matrix, path, i - 1, j, index + 1) ||
                     dfs(matrix, path, i, j + 1, index + 1) ||
                     dfs(matrix, path, i, j - 1, index + 1);
        matrix[i][j] = temp;
        return found;
    }
};