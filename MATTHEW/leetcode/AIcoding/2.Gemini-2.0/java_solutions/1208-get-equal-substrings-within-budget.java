class Solution {
    public int equalSubstring(String s, String t, int maxCost) {
        int n = s.length();
        int left = 0;
        int right = 0;
        int cost = 0;
        int maxLength = 0;

        while (right < n) {
            cost += Math.abs(s.charAt(right) - t.charAt(right));

            while (cost > maxCost) {
                cost -= Math.abs(s.charAt(left) - t.charAt(left));
                left++;
            }

            maxLength = Math.max(maxLength, right - left + 1);
            right++;
        }

        return maxLength;
    }
}