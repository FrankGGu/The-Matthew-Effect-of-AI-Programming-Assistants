class Solution {
    public int maximumScore(int[] nums, int k) {
        int n = nums.length;
        int left = k, right = k;
        int minVal = nums[k];
        int maxScore = minVal;

        while (left > 0 || right < n - 1) {
            if (left == 0) {
                right++;
            } else if (right == n - 1) {
                left--;
            } else if (nums[left - 1] < nums[right + 1]) {
                right++;
            } else {
                left--;
            }

            minVal = Math.min(minVal, Math.min((left > 0) ? nums[left] : Integer.MAX_VALUE, (right < n - 1) ? nums[right] : Integer.MAX_VALUE));

            int currentMin = nums[k];
            for(int i = left; i <= right; i++){
                currentMin = Math.min(currentMin, nums[i]);
            }

            maxScore = Math.max(maxScore, currentMin * (right - left + 1));
        }

        return maxScore;
    }
}