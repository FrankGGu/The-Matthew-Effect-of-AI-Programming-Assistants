class Solution {
public:
    int longestContinuousIncreasingSubsequence(vector<int>& nums) {
        if (nums.empty()) return 0;
        int maxLength = 1, currentLength = 1;

        for (int i = 1; i < nums.size(); i++) {
            if (nums[i] > nums[i - 1]) {
                currentLength++;
            } else {
                maxLength = max(maxLength, currentLength);
                currentLength = 1;
            }
        }

        return max(maxLength, currentLength);
    }
};