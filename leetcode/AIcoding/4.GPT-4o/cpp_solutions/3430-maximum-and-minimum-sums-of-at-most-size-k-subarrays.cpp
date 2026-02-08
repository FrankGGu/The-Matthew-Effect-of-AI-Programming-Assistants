#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    vector<long long> maximumAndMinimumSums(vector<int>& nums, int k) {
        long long maxSum = LLONG_MIN, minSum = LLONG_MAX;
        int n = nums.size();

        // Using a sliding window to calculate sums of subarrays of size k
        long long currentSum = 0;
        for (int i = 0; i < n; i++) {
            currentSum += nums[i];
            if (i >= k) {
                currentSum -= nums[i - k];
            }
            if (i >= k - 1) {
                maxSum = max(maxSum, currentSum);
                minSum = min(minSum, currentSum);
            }
        }

        return {maxSum, minSum};
    }
};