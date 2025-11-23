class Solution {
public:
    int numSubmatrixSumLessThanK(vector<vector<int>>& matrix, int k) {
        int m = matrix.size(), n = matrix[0].size();
        vector<vector<int>> prefix(m + 1, vector<int>(n + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                prefix[i][j] = matrix[i - 1][j - 1] + prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1];
            }
        }

        int count = 0;
        for (int left = 0; left < n; ++left) {
            for (int right = left; right < n; ++right) {
                vector<int> sums(m);
                for (int row = 0; row < m; ++row) {
                    sums[row] = prefix[row + 1][right + 1] - prefix[row + 1][left] - prefix[0][right + 1] + prefix[0][left];
                }
                count += countSubarraysWithSumLessThanK(sums, k);
            }
        }
        return count;
    }

private:
    int countSubarraysWithSumLessThanK(const vector<int>& sums, int k) {
        int count = 0, current_sum = 0;
        unordered_map<int, int> prefix_sum_count;
        prefix_sum_count[0] = 1;

        for (int sum : sums) {
            current_sum += sum;
            if (current_sum < k) {
                count += prefix_sum_count[current_sum];
            }
            count += prefix_sum_count[current_sum - k];
            prefix_sum_count[current_sum]++;
        }
        return count;
    }
};