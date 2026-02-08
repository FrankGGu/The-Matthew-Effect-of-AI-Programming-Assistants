class Solution {
public:
    vector<vector<int>> findGoodSubset(vector<vector<int>>& matrix) {
        int n = matrix.size();
        int m = matrix[0].size();
        vector<vector<int>> result;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (matrix[i][j] > 0) {
                    vector<int> subset;
                    for (int k = 0; k < n; ++k) {
                        for (int l = 0; l < m; ++l) {
                            if (matrix[k][l] > 0) {
                                subset.push_back(matrix[k][l]);
                            }
                        }
                    }
                    result.push_back(subset);
                }
            }
        }
        return result;
    }
};