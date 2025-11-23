class Solution {
    public int longestSubsequence(int[] arr, int difference) {
        Map<Integer, Integer> dp = new HashMap<>();
        int maxLength = 0;

        for (int num : arr) {
            int prevNum = num - difference;
            int currentLength = dp.getOrDefault(prevNum, 0) + 1;
            dp.put(num, currentLength);
            maxLength = Math.max(maxLength, currentLength);
        }

        return maxLength;
    }
}