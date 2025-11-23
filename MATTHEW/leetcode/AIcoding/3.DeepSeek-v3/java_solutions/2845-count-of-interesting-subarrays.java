class Solution {
    public long countInterestingSubarrays(List<Integer> nums, int modulo, int k) {
        Map<Integer, Integer> prefixCount = new HashMap<>();
        prefixCount.put(0, 1);
        long res = 0;
        int prefix = 0;

        for (int num : nums) {
            if (num % modulo == k) {
                prefix = (prefix + 1) % modulo;
            }
            int target = (prefix - k + modulo) % modulo;
            res += prefixCount.getOrDefault(target, 0);
            prefixCount.put(prefix, prefixCount.getOrDefault(prefix, 0) + 1);
        }

        return res;
    }
}