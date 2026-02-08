class Solution {
    public long countPairs(int[] nums, int k) {
        long count = 0;
        int n = nums.length;
        int[] gcdCount = new int[k + 1];

        for (int num : nums) {
            int gcdNumK = gcd(num, k);
            for (int i = 1; i <= k; i++) {
                if (gcdCount[i] > 0 && (long)gcdNumK * i % k == 0) {
                    count += gcdCount[i];
                }
            }
            gcdCount[gcdNumK]++;
        }

        return count;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}