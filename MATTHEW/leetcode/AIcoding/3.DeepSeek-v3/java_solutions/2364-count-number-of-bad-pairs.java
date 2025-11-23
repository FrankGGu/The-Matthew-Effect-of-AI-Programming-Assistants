class Solution {
    public long countBadPairs(int[] nums) {
        Map<Integer, Integer> map = new HashMap<>();
        long total = 0;
        long good = 0;
        int n = nums.length;
        for (int i = 0; i < n; i++) {
            int key = nums[i] - i;
            good += map.getOrDefault(key, 0);
            map.put(key, map.getOrDefault(key, 0) + 1);
            total += i;
        }
        return total - good;
    }
}