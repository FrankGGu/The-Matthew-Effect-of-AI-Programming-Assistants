class Solution {
    public long countBadPairs(int[] nums) {
        long n = nums.length;
        long totalPairs = n * (n - 1) / 2;
        long goodPairs = 0;
        Map<Integer, Integer> map = new HashMap<>();

        for (int i = 0; i < n; i++) {
            goodPairs += map.getOrDefault(i - nums[i], 0);
            map.put(i - nums[i], map.getOrDefault(i - nums[i], 0) + 1);
        }

        return totalPairs - goodPairs;
    }
}