class Solution {
public:
    int maxMatrixSum(vector<vector<int>>& matrix) {
        long long sum = 0;
        int negativeCount = 0;
        int minVal = INT_MAX;

        for (const auto& row : matrix) {
            for (int val : row) {
                if (val < 0) {
                    negativeCount++;
                }
                sum += abs(val);
                minVal = min(minVal, abs(val));
            }
        }

        if (negativeCount % 2 == 0) {
            return sum;
        } else {
            return sum - 2 * minVal;
        }
    }
};