public class Solution {
    public int minLengthAfterRemovals(String s) {
        int n = s.length();
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int maxCount = 0;
        for (int c : count) {
            maxCount = Math.max(maxCount, c);
        }
        return Math.max(n - 2 * (n - maxCount), 0);
    }
}