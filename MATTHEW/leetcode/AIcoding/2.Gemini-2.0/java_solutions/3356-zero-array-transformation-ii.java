class Solution {
    public boolean canTransform(int[] nums) {
        int n = nums.length;
        int[] cnt = new int[2];
        for (int x : nums) {
            cnt[x]++;
        }
        if (cnt[0] != n / 2) {
            return false;
        }
        int zeros = 0;
        for (int x : nums) {
            if (x == 0) {
                zeros++;
            }
        }
        int ones = n - zeros;

        int zerosFromLeft = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) {
                zerosFromLeft++;
            }
        }

        int zerosFromRight = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (nums[i] == 0) {
                zerosFromRight++;
            }
        }

        int[] p = new int[n];
        int[] q = new int[n];
        int pIdx = 0;
        int qIdx = 0;
        for (int i = 0; i < n; i++) {
            if (nums[i] == 0) {
                p[pIdx++] = i;
            }
        }

        int[] sortedNums = nums.clone();
        java.util.Arrays.sort(sortedNums);

        for (int i = 0; i < n; i++) {
            if (sortedNums[i] == 0) {
                q[qIdx++] = i;
            }
        }

        for (int i = 0; i < n / 2; i++) {
            if (p[i] > q[i]) {
                return false;
            }
        }

        return true;
    }
}