class Solution {
    public boolean isGoodArray(int[] nums) {
        int currentGcd = nums[0];
        for (int i = 1; i < nums.length; i++) {
            currentGcd = gcd(currentGcd, nums[i]);
            if (currentGcd == 1) {
                return true;
            }
        }
        return currentGcd == 1;
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