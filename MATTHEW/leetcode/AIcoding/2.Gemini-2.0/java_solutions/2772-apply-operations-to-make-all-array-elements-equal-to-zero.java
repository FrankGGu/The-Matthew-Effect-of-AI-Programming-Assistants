class Solution {
    public boolean checkArray(int[] nums, int k) {
        int n = nums.length;
        long[] diff = new long[n];
        long currentDiff = 0;
        for (int i = 0; i < n; i++) {
            currentDiff += diff[i];
            if (nums[i] + currentDiff < 0) {
                return false;
            }
            long reduce = nums[i] + currentDiff;
            if (reduce > 0) {
                if (i + k > n) {
                    return false;
                }
                diff[i] -= reduce;
                if (i + k < n) {
                    diff[i + k] += reduce;
                }
                currentDiff -= reduce;
            }
        }
        return true;
    }
}