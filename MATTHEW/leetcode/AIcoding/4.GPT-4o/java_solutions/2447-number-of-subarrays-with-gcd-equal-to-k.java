class Solution {
    public int subarrayGCD(int[] nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.length; i++) {
            int gcd = 0;
            for (int j = i; j < nums.length; j++) {
                gcd = gcd(gcd, nums[j]);
                if (gcd < k) break;
                if (gcd == k) count++;
            }
        }
        return count;
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