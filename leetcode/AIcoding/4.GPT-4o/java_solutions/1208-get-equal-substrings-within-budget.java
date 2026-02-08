class Solution {
    public int equalSubstring(String s, String t, int maxCost) {
        int n = s.length();
        int[] cost = new int[n];
        for (int i = 0; i < n; i++) {
            cost[i] = Math.abs(s.charAt(i) - t.charAt(i));
        }

        int left = 0, right = 0, totalCost = 0, maxLength = 0;

        while (right < n) {
            totalCost += cost[right];
            while (totalCost > maxCost) {
                totalCost -= cost[left];
                left++;
            }
            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }

        return maxLength;
    }
}