class Solution {
public:
    vector<bool> gridGame(vector<vector<int>>& grid) {
        int n = grid[0].size();
        vector<bool> result(n, false);
        vector<long long> prefixSum(2, 0);

        for (int j = 0; j < n; ++j) {
            prefixSum[0] += grid[0][j];
            prefixSum[1] += grid[1][j];
        }

        long long firstRowSum = 0;
        for (int j = 0; j < n; ++j) {
            firstRowSum += grid[0][j];
            long long secondRowSum = prefixSum[1] - grid[1][j];
            if (firstRowSum < secondRowSum) {
                result[j] = true;
            }
        }

        return result;
    }
};