class Solution {
    public long beautifulSubarrays(int[] nums) {
        HashMap<Integer, Integer> prefixXorCount = new HashMap<>();
        prefixXorCount.put(0, 1);
        int prefixXor = 0;
        long result = 0;

        for (int num : nums) {
            prefixXor ^= num;
            result += prefixXorCount.getOrDefault(prefixXor, 0);
            prefixXorCount.put(prefixXor, prefixXorCount.getOrDefault(prefixXor, 0) + 1);
        }

        return result;
    }
}