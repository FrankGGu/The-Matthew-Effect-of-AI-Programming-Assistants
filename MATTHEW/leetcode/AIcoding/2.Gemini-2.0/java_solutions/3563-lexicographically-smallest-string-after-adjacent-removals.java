import java.util.Stack;

class Solution {
    public String lastNonEmptyString(String s) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        int maxFreq = 0;
        for (int f : freq) {
            maxFreq = Math.max(maxFreq, f);
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            if (freq[s.charAt(i) - 'a'] == maxFreq) {
                sb.append(s.charAt(i));
                freq[s.charAt(i) - 'a'] = -1;
            }
        }
        return sb.toString();
    }
}