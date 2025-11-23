public class Solution {
    public String reverseDegree(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                char c = (char) ('a' + i);
                for (int j = 0; j < count[i]; j++) {
                    result.append(c);
                }
            }
        }
        return result.toString();
    }
}