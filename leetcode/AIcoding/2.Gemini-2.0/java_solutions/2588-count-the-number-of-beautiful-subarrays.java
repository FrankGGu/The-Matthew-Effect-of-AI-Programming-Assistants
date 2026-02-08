class Solution {
    public long beautifulSubarrays(int[] nums) {
        Map<Integer, Integer> prefixXorCount = new HashMap<>();
        prefixXorCount.put(0, 1);
        int prefixXor = 0;
        long count = 0;
        for (int num : nums) {
            prefixXor ^= num;
            count += prefixXorCount.getOrDefault(prefixXor, 0);
            prefixXorCount.put(prefixXor, prefixXorCount.getOrDefault(prefixXor, 0) + 1);
        }
        return count;
    }
}