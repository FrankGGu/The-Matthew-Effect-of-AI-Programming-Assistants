class Solution {
    public int longestSubsequence(int[] arr, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int max = 0;
        for (int num : arr) {
            int prev = num - difference;
            int current = dp.getOrDefault(prev, 0) + 1;
            dp.put(num, current);
            max = Math.max(max, current);
        }
        return max;
    }
}