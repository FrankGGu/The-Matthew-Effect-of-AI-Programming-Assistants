class Solution {
public:
    int longestAlternatingSubarray(vector<int>& nums) {
        int maxLength = 0;
        int currentLength = 0;

        for (int i = 0; i < nums.size(); i++) {
            if (i == 0 || (nums[i] - nums[i - 1]) * (nums[i - 1] - (i > 1 ? nums[i - 2] : 0)) < 0) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            maxLength = max(maxLength, currentLength);
        }

        return maxLength;
    }
};