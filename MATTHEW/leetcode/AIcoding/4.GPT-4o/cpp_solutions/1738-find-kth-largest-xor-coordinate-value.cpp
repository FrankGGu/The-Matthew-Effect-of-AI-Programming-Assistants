class Solution {
public:
    int kthLargestValue(vector<vector<int>>& matrix, int k) {
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> xorMatrix(m + 1, vector<int>(n + 1, 0));
        vector<int> values;

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                xorMatrix[i][j] = matrix[i - 1][j - 1] ^ xorMatrix[i - 1][j] ^ xorMatrix[i][j - 1] ^ xorMatrix[i - 1][j - 1];
                values.push_back(xorMatrix[i][j]);
            }
        }

        nth_element(values.begin(), values.begin() + values.size() - k, values.end());
        return values[values.size() - k];
    }
};