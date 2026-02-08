class Solution {
    public int subarrayGCD(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int gcd = 0;
            for (int j = i; j < nums.length; j++) {
                gcd = findGCD(gcd, nums[j]);
                if (gcd == k) {
                    count++;
                }
            }
        }
        return count;
    }

    private int findGCD(int a, int b) {
        if (b == 0) {
            return a;
        }
        return findGCD(b, a % b);
    }
}