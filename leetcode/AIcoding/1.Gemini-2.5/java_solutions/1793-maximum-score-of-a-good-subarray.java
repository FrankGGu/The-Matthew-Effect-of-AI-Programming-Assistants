class Solution {
    public int maximumScore(int[] nums, int k) {
        int n = nums.length;
        int left = k;
        int right = k;
        int minVal = nums[k];
        int maxScore = nums[k];

        while (left > 0 || right < n - 1) {
            if (left == 0) { // Can only expand right
                right++;
                minVal = Math.min(minVal, nums[right]);
            } else if (right == n - 1) { // Can only expand left
                left--;
                minVal = Math.min(minVal, nums[left]);
            } else if (nums[left - 1] < nums[right + 1]) { // Expand right if element to the right is greater or equal
                right++;
                minVal = Math.min(minVal, nums[right]);
            } else { // Expand left if element to the left is greater
                left--;
                minVal = Math.min(minVal, nums[left]);
            }
            maxScore = Math.max(maxScore, minVal * (right - left + 1));
        }

        return maxScore;
    }
}