class Solution {
public:
    int longestNiceSubarray(vector<int>& nums) {
        int left = 0;
        int max_len = 1;
        int current_or = 0;

        for (int right = 0; right < nums.size(); ++right) {
            while ((current_or & nums[right]) != 0) {
                current_or ^= nums[left];
                ++left;
            }
            current_or |= nums[right];
            max_len = max(max_len, right - left + 1);
        }

        return max_len;
    }
};