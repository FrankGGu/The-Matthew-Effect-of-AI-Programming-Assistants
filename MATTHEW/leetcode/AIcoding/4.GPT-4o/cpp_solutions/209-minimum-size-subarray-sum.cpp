class Solution {
public:
    int minSubArrayLen(int target, vector<int>& nums) {
        int left = 0, sum = 0, minLength = INT_MAX;
        for (int right = 0; right < nums.size(); ++right) {
            sum += nums[right];
            while (sum >= target) {
                minLength = min(minLength, right - left + 1);
                sum -= nums[left++];
            }
        }
        return minLength == INT_MAX ? 0 : minLength;
    }
};