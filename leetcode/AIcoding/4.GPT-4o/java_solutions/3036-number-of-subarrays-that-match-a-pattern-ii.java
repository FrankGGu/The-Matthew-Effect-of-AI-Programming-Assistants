class Solution {
    public int countSubarrays(int[] nums, int[] minK, int[] maxK) {
        int count = 0;
        int n = nums.length;
        int minKCount = 0, maxKCount = 0;

        for (int left = 0, right = 0; right < n; right++) {
            if (nums[right] < minK[0] || nums[right] > maxK[0]) {
                left = right + 1;
                minKCount = 0;
                maxKCount = 0;
            } else {
                if (nums[right] == minK[0]) minKCount++;
                if (nums[right] == maxK[0]) maxKCount++;
                while (minKCount > 0 && maxKCount > 0) {
                    count += n - right;
                    if (nums[left] == minK[0]) minKCount--;
                    if (nums[left] == maxK[0]) maxKCount--;
                    left++;
                }
            }
        }

        return count;
    }
}