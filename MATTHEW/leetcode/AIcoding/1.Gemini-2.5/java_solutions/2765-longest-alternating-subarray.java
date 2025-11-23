class Solution {
    public int longestAlternatingSubarray(int[] nums, int threshold) {
        int maxLength = 0;
        int n = nums.length;

        for (int i = 0; i < n; i++) {
            if (nums[i] % 2 == 0 && nums[i] <= threshold) {
                int currentLength = 1;
                for (int j = i + 1; j < n; j++) {
                    if (nums[j] <= threshold && (nums[j] % 2 != nums[j-1] % 2)) {
                        currentLength++;
                    } else {
                        break;
                    }
                }
                maxLength = Math.max(maxLength, currentLength);
            }
        }
        return maxLength;
    }
}