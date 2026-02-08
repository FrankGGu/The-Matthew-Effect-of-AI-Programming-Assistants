class Solution {
    public boolean isGoodArray(int[] nums) {
        int gcd = nums[0];
        for (int num : nums) {
            gcd = computeGCD(gcd, num);
            if (gcd == 1) {
                return true;
            }
        }
        return gcd == 1;
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