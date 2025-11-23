#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    long long sumOfVariableLengthSubarrays(vector<int>& nums, int k) {
        int n = nums.size();
        long long totalSum = 0;

        for (int len = 1; len <= n; ++len) {
            for (int i = 0; i <= n - len; ++i) {
                long long currentSum = 0;
                for (int j = i; j < i + len; ++j) {
                    currentSum += nums[j];
                }
                if (len >= k)
                    totalSum += currentSum;
            }
        }

        return totalSum;
    }
};