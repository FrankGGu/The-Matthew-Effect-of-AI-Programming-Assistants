class Solution {
    public long maximumSubsequenceCount(String text, String pattern) {
        long count1 = 0;
        long count2 = 0;
        long ans = 0;
        for (char c : text.toCharArray()) {
            if (c == pattern.charAt(1)) {
                count2++;
                ans += count1;
            }
            if (c == pattern.charAt(0)) {
                count1++;
            }
        }
        return ans + Math.max(count1, count2);
    }
}