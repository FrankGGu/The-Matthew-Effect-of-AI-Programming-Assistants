#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumTwoNoOverlap(vector<int>& nums, int firstLen, int secondLen) {
        int n = nums.size();
        vector<int> prefixSum(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
        }

        int maxSum = 0;
        for (int i = firstLen; i <= n; ++i) {
            int firstSubarraySum = prefixSum[i] - prefixSum[i - firstLen];
            for (int j = secondLen; j <= i - firstLen; ++j) {
                int secondSubarraySum = prefixSum[j] - prefixSum[j - secondLen];
                maxSum = max(maxSum, firstSubarraySum + secondSubarraySum);
            }
            for (int j = i + firstLen; j <= n; ++j) {
                int secondSubarraySum = prefixSum[j] - prefixSum[j - secondLen];
                maxSum = max(maxSum, firstSubarraySum + secondSubarraySum);
            }
        }
        return maxSum;
    }
};