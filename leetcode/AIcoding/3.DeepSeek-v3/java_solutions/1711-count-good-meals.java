class Solution {
    public int countPairs(int[] deliciousness) {
        int MOD = 1_000_000_007;
        int maxSum = 0;
        for (int num : deliciousness) {
            maxSum += num;
        }
        maxSum = Integer.highestOneBit(maxSum) << 1;

        Map<Integer, Integer> freq = new HashMap<>();
        int res = 0;
        for (int num : deliciousness) {
            for (int sum = 1; sum <= maxSum; sum <<= 1) {
                int complement = sum - num;
                res = (res + freq.getOrDefault(complement, 0)) % MOD;
            }
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        return res;
    }
}