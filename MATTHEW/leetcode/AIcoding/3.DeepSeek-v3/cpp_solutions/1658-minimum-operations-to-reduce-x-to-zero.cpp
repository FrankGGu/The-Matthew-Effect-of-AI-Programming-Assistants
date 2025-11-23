class Solution {
public:
    int minOperations(vector<int>& nums, int x) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }
        int target = total - x;
        if (target < 0) {
            return -1;
        }
        if (target == 0) {
            return nums.size();
        }

        int left = 0, current = 0, max_len = -1;
        for (int right = 0; right < nums.size(); ++right) {
            current += nums[right];
            while (current > target) {
                current -= nums[left];
                left++;
            }
            if (current == target) {
                max_len = max(max_len, right - left + 1);
            }
        }

        return max_len == -1 ? -1 : nums.size() - max_len;
    }
};