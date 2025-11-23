class Solution {
public:
    int maxSubarrays(vector<int>& nums) {
        int minAnd = nums[0];
        for (int num : nums) {
            minAnd &= num;
        }
        if (minAnd != 0) {
            return 1;
        }
        int currentAnd = INT_MAX;
        int count = 0;
        for (int num : nums) {
            currentAnd &= num;
            if (currentAnd == 0) {
                count++;
                currentAnd = INT_MAX;
            }
        }
        return count;
    }
};