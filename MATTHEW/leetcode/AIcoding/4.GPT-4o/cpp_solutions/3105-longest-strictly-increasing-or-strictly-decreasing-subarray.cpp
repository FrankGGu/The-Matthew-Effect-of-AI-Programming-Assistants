class Solution {
public:
    int longestAlternatingSubarray(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return n;

        int maxLength = 1;
        int currentLength = 1;

        for (int i = 1; i < n; i++) {
            if ((nums[i] > nums[i - 1] && currentLength > 0) || 
                (nums[i] < nums[i - 1] && currentLength < 0)) {
                currentLength = -currentLength + 1;
            } else if (nums[i] != nums[i - 1]) {
                currentLength = 2;
            } else {
                currentLength = 0;
            }
            maxLength = max(maxLength, abs(currentLength));
        }

        return maxLength;
    }
};