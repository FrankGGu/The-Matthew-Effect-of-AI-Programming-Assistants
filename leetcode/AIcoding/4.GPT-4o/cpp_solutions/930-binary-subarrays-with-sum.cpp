class Solution {
public:
    int numSubarraysWithSum(vector<int>& nums, int goal) {
        return atMost(nums, goal) - atMost(nums, goal - 1);
    }

    int atMost(vector<int>& nums, int goal) {
        int count = 0, left = 0;
        for (int right = 0; right < nums.size(); ++right) {
            goal -= nums[right];
            while (goal < 0) {
                goal += nums[left++];
            }
            count += right - left + 1;
        }
        return count;
    }
};