class Solution {
    public boolean isGood(int[] nums) {
        int n = nums.length;

        if (n == 1) {
            return false;
        }

        int[] counts = new int[n + 1];

        for (int num : nums) {
            if (num >= n) {
                return false;
            }
            counts[num]++;
        }

        for (int i = 1; i <= n - 2; i++) {
            if (counts[i] != 1) {
                return false;
            }
        }

        if (counts[n - 1] != 2) {
            return false;
        }

        return true;
    }
}