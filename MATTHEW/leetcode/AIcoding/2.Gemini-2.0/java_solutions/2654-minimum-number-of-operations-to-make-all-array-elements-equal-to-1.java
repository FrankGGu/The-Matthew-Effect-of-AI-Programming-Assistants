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

        int minOperations = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int gcd = nums[i];
            for (int j = i + 1; j < n; j++) {
                gcd = gcd(gcd, nums[j]);
                if (gcd == 1) {
                    minOperations = Math.min(minOperations, j - i);
                    break;
                }
            }
        }

        if (minOperations == Integer.MAX_VALUE) {
            return -1;
        }

        return minOperations + n - 1;
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}