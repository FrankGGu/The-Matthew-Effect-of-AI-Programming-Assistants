class Solution {
    public long countBeautifulSubarrays(int[] nums) {
        Map<Integer, Long> countMap = new HashMap<>();
        countMap.put(0, 1L);
        long result = 0;
        int prefixXor = 0;

        for (int num : nums) {
            prefixXor ^= num;
            result += countMap.getOrDefault(prefixXor ^ 1, 0L);
            countMap.put(prefixXor, countMap.getOrDefault(prefixXor, 0L) + 1);
        }

        return result;
    }
}