public class Solution {
    public int maximumLengthSubstring(String s) {
        int n = s.length();
        int left = 0;
        int maxLen = 0;
        java.util.HashMap<Character, Integer> count = new java.util.HashMap<>();

        for (int right = 0; right < n; right++) {
            char c = s.charAt(right);
            count.put(c, count.getOrDefault(c, 0) + 1);

            while (count.get(c) > 2) {
                char leftChar = s.charAt(left);
                count.put(leftChar, count.get(leftChar) - 1);
                if (count.get(leftChar) == 0) {
                    count.remove(leftChar);
                }
                left++;
            }

            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}