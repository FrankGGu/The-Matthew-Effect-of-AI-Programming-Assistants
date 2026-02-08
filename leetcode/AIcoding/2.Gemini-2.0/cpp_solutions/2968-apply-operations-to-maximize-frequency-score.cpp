#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxFrequencyScore(vector<int>& nums, long long k) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int left = 0;
        long long currentCost = 0;
        int maxFreq = 0;

        for (int right = 0; right < n; right++) {
            long long target = nums[right];
            currentCost += (long long)(right - left) * (target - nums[right - 1]);
            if (right > 0) {
                long long costToAdd = (long long)(right - left) * (target - nums[right-1]);
            }

            while (currentCost > k) {
                currentCost -= (long long)(right - left) * (nums[left + 1] - nums[left]);
                left++;
            }
            maxFreq = max(maxFreq, right - left + 1);
        }

        return maxFreq;
    }
};