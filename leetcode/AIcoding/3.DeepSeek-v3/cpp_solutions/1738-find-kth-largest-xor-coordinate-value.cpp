class Solution {
public:
    int kthLargestValue(vector<vector<int>>& matrix, int k) {
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> prefix(m + 1, vector<int>(n + 1, 0));
        vector<int> results;

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                prefix[i][j] = prefix[i-1][j] ^ prefix[i][j-1] ^ prefix[i-1][j-1] ^ matrix[i-1][j-1];
                results.push_back(prefix[i][j]);
            }
        }

        nth_element(results.begin(), results.begin() + k - 1, results.end(), greater<int>());
        return results[k-1];
    }
};