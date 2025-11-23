#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxFrequency(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        int left = 0, right = 0;
        long long sum = 0;
        int maxFreq = 0;

        while (right < nums.size()) {
            sum += nums[right];

            while ((long long)nums[right] * (right - left + 1) > sum + k) {
                sum -= nums[left];
                left++;
            }

            maxFreq = max(maxFreq, right - left + 1);
            right++;
        }

        return maxFreq;
    }
};