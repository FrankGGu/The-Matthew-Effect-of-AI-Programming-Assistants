#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxFrequency(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int left = 0;
        long long currentSum = 0;
        int maxFreq = 0;
        for (int right = 0; right < nums.size(); right++) {
            currentSum += nums[right];
            while ((long long)(right - left + 1) * nums[right] - currentSum > k) {
                currentSum -= nums[left];
                left++;
            }
            maxFreq = max(maxFreq, right - left + 1);
        }
        return maxFreq;
    }
};