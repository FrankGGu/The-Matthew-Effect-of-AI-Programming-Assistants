class Solution {
public:
    int longestNonDecreasingArray(vector<int>& nums) {
        int maxLength = 1, currentLength = 1;
        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] >= nums[i - 1]) {
                currentLength++;
            } else {
                currentLength = 1;
            }
            maxLength = max(maxLength, currentLength);
        }
        return maxLength;
    }
};