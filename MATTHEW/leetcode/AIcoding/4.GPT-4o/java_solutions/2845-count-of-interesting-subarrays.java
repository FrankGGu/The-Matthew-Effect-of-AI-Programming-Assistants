class Solution {
    public int countInterestingSubarrays(int[] nums, int modulo, int k) {
        int count = 0, prefixSum = 0;
        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, 1);

        for (int num : nums) {
            if (num % modulo == k) {
                prefixSum++;
            }
            count += map.getOrDefault((prefixSum % (modulo)), 0);
            map.put(prefixSum % modulo, map.getOrDefault(prefixSum % modulo, 0) + 1);
        }

        return count;
    }
}