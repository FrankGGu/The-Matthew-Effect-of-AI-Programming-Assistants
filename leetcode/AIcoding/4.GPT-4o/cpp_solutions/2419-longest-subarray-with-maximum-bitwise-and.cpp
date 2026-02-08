class Solution {
public:
    int longestSubarray(vector<int>& nums) {
        int maxAnd = *max_element(nums.begin(), nums.end());
        int maxLength = 0, currentLength = 0;

        for (int num : nums) {
            if (num == maxAnd) {
                currentLength++;
                maxLength = max(maxLength, currentLength);
            } else {
                currentLength = 0;
            }
        }

        return maxLength;
    }
};