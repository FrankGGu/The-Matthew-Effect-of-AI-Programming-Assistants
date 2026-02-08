class Solution {
public:
    int minSubArrayLen(int target, std::vector<int>& nums) {
        int n = nums.size();
        int min_len = INT_MAX;
        int current_sum = 0;
        int left = 0;

        for (int right = 0; right < n; ++right) {
            current_sum += nums[right];
            while (current_sum >= target) {
                min_len = std::min(min_len, right - left + 1);
                current_sum -= nums[left];
                left++;
            }
        }

        return (min_len == INT_MAX) ? 0 : min_len;
    }
};