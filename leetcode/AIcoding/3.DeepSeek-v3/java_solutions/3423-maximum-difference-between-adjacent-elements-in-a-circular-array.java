class Solution {
    public int maxDifference(int[] nums) {
        int n = nums.length;
        int maxDiff = -1;
        for (int i = 0; i < n; i++) {
            int current = nums[i];
            int next = nums[(i + 1) % n];
            int diff = Math.abs(next - current);
            if (diff > maxDiff) {
                maxDiff = diff;
            }
        }
        return maxDiff;
    }
}