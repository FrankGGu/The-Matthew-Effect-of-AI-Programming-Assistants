class Solution {
public:
    long long getDescentPeriods(vector<int>& prices) {
        long long result = 0;
        int n = prices.size();
        int left = 0;

        for (int right = 0; right < n; ++right) {
            if (right > 0 && prices[right] != prices[right - 1] - 1) {
                left = right;
            }
            result += right - left + 1;
        }

        return result;
    }
};