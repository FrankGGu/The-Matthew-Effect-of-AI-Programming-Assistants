class Solution {
public:
    long long maximumGood(vector<vector<int>>& statements) {
        int n = statements.size();
        long long maxSum = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            bool valid = true;
            long long currentSum = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    currentSum += i + 1;
                    for (int j = 0; j < n; ++j) {
                        if (statements[i][j] != 2 && ((mask & (1 << j)) >> j) != statements[i][j]) {
                            valid = false;
                            break;
                        }
                    }
                }
                if (!valid) break;
            }
            if (valid) {
                maxSum = max(maxSum, currentSum);
            }
        }

        return maxSum;
    }
};