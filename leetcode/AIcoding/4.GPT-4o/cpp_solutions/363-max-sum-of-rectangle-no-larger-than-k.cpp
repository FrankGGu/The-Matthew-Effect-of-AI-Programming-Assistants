class Solution {
public:
    int maxSumSubmatrix(vector<vector<int>>& matrix, int k) {
        int rows = matrix.size();
        int cols = matrix[0].size();
        int maxSum = INT_MIN;

        for (int left = 0; left < cols; ++left) {
            vector<int> sums(rows, 0);
            for (int right = left; right < cols; ++right) {
                for (int r = 0; r < rows; ++r) {
                    sums[r] += matrix[r][right];
                }

                set<int> sumSet;
                sumSet.insert(0);
                int currSum = 0;

                for (int sum : sums) {
                    currSum += sum;
                    auto it = sumSet.lower_bound(currSum - k);
                    if (it != sumSet.end()) {
                        maxSum = max(maxSum, currSum - *it);
                    }
                    sumSet.insert(currSum);
                }
            }
        }
        return maxSum;
    }
};