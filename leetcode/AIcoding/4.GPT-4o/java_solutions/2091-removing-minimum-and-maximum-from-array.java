class Solution {
    public int minimumDeletions(int[] nums) {
        int n = nums.length;
        if (n <= 2) return n;

        int minIndex = 0, maxIndex = 0;
        for (int i = 1; i < n; i++) {
            if (nums[i] < nums[minIndex]) minIndex = i;
            if (nums[i] > nums[maxIndex]) maxIndex = i;
        }

        int left = Math.min(minIndex, maxIndex) + 1;
        int right = Math.max(minIndex, maxIndex) + 1;
        int totalDeletions = Math.max(left, n - right + 1);

        return Math.min(totalDeletions, Math.min(left + (n - right), right + (n - left)));
    }
}