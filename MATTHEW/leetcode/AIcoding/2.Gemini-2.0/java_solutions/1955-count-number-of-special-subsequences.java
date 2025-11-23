class Solution {
    public int countSpecialSubsequences(int[] nums) {
        long mod = 1000000007;
        long endWith0 = 0;
        long endWith1 = 0;
        long endWith2 = 0;

        for (int num : nums) {
            if (num == 0) {
                endWith0 = (2 * endWith0 + 1) % mod;
            } else if (num == 1) {
                endWith1 = (2 * endWith1 + endWith0) % mod;
            } else {
                endWith2 = (2 * endWith2 + endWith1) % mod;
            }
        }

        return (int) endWith2;
    }
}