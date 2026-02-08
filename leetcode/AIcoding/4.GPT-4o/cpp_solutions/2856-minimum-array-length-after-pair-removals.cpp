class Solution {
public:
    int minimumLengthAfterRemovals(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        int maxLen = 1;
        int currentLen = 1;

        for (int i = 1; i < n; ++i) {
            if (nums[i] == nums[i - 1]) {
                currentLen++;
            } else {
                maxLen = max(maxLen, currentLen);
                currentLen = 1;
            }
        }
        maxLen = max(maxLen, currentLen);

        return n - maxLen;
    }
};