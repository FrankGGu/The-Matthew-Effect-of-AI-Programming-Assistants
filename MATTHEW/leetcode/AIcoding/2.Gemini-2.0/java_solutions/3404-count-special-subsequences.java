class Solution {
    public int countSpecialSubsequences(int[] nums) {
        long zero = 0;
        long one = 0;
        long two = 0;
        int mod = 1000000007;

        for (int num : nums) {
            if (num == 0) {
                zero = (zero * 2 + 1) % mod;
            } else if (num == 1) {
                one = (one * 2 + zero) % mod;
            } else {
                two = (two * 2 + one) % mod;
            }
        }

        return (int) two;
    }
}