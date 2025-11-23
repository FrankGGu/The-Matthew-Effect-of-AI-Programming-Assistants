class Solution {
    public int minChanges(int[] nums) {
        int n = nums.length;
        if (n == 1) return 0;

        int[] diff = new int[n - 1];
        for (int i = 0; i < n - 1; i++) {
            diff[i] = nums[i + 1] - nums[i];
        }

        int res = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int changes = 0;
            if (i > 0) {
                int newDiff = (i < n - 1) ? nums[i + 1] - nums[i - 1] : 0;
                if (i > 1) {
                    if (newDiff != diff[i - 2]) changes++;
                }
                if (i < n - 2) {
                    if (newDiff != diff[i + 1]) changes++;
                }
                changes += countChanges(diff, 0, i - 2, newDiff);
                changes += countChanges(diff, i + 2, n - 2, newDiff);
            } else {
                changes = countChanges(diff, 1, n - 2, diff[0]);
            }
            res = Math.min(res, changes);
        }
        return res;
    }

    private int countChanges(int[] diff, int start, int end, int target) {
        if (start > end) return 0;
        int changes = 0;
        for (int i = start; i <= end; i++) {
            if (diff[i] != target) changes++;
        }
        return changes;
    }
}