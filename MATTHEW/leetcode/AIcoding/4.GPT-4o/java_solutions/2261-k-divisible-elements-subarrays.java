class Solution {
    public int countKDivisibleSubarrays(int[] nums, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        Map<Long, Integer> countMap = new HashMap<>();
        countMap.put(0L, 1);
        int result = 0;

        for (int i = 1; i <= n; i++) {
            long mod = prefixSum[i] % k;
            if (mod < 0) mod += k;
            result += countMap.getOrDefault(mod, 0);
            countMap.put(mod, countMap.getOrDefault(mod, 0) + 1);
        }

        return result;
    }
}