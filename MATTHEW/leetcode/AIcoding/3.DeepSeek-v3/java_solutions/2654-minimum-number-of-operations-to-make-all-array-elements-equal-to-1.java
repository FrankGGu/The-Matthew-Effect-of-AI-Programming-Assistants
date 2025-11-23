class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
            }
        }
        if (ones > 0) {
            return n - ones;
        }

        int minOps = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int gcd = nums[i];
            for (int j = i + 1; j < n; j++) {
                gcd = computeGCD(gcd, nums[j]);
                if (gcd == 1) {
                    minOps = Math.min(minOps, j - i + (n - 1));
                    break;
                }
            }
        }
        return minOps == Integer.MAX_VALUE ? -1 : minOps;
    }

    private int computeGCD(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}