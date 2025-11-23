class Solution {
    public long countAlmostEqualPairs(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        long count = 0;
        for (int num : nums) {
            count += freq.getOrDefault(num, 0);
            count += freq.getOrDefault(num - 1, 0);
            count += freq.getOrDefault(num + 1, 0);
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        return count;
    }
}