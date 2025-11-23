class Solution {
    public long countPairs(int[] nums, int k) {
        Map<Integer, Integer> gcdCount = new HashMap<>();
        long res = 0;
        for (int num : nums) {
            int gcd1 = gcd(num, k);
            for (int gcd2 : gcdCount.keySet()) {
                if ((long) gcd1 * gcd2 % k == 0) {
                    res += gcdCount.get(gcd2);
                }
            }
            gcdCount.put(gcd1, gcdCount.getOrDefault(gcd1, 0) + 1);
        }
        return res;
    }

    private int gcd(int a, int b) {
        if (b == 0) {
            return a;
        }
        return gcd(b, a % b);
    }
}