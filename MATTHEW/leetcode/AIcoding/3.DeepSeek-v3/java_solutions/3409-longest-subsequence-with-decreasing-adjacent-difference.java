class Solution {
    public int longestSubsequence(int[] arr, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int max = 0;
        for (int num : arr) {
            int prev = num - difference;
            int curr = dp.getOrDefault(prev, 0) + 1;
            dp.put(num, curr);
            max = Math.max(max, curr);
        }
        return max;
    }
}