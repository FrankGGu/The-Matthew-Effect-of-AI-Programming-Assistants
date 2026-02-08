#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    long long sumOfKSubarrays(vector<int>& nums, int k, int m) {
        int n = nums.size();
        vector<long long> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<long long> minPrefix(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            minPrefix[i] = prefix[i];
            if (i > 0) {
                minPrefix[i] = min(minPrefix[i], minPrefix[i - 1]);
            }
        }

        long long result = 0;
        for (int i = 0; i <= n - k; ++i) {
            long long currentSum = prefix[i + k] - prefix[i];
            int left = i;
            int right = i + k;
            int len = right - left;
            if (len >= m) {
                result += currentSum;
            } else {
                int required = m - len;
                int start = max(0, i - required);
                int end = min(n - k, i);
                for (int j = start; j <= end; ++j) {
                    long long subarraySum = prefix[j + k] - prefix[j];
                    result += subarraySum;
                }
            }
        }

        return result;
    }
};