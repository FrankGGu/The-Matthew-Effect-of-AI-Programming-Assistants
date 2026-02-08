public class Solution {
    public String minimizeStringValue(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            if (c != '?') {
                count[c - 'a']++;
            }
        }

        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            if (c == '?') {
                for (int i = 0; i < 26; i++) {
                    if (count[i] > 0) {
                        sb.append((char) ('a' + i));
                        count[i]--;
                        break;
                    }
                }
            } else {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}