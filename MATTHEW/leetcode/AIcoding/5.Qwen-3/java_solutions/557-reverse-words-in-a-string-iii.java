public class Solution {
    public String reverseWords(String s) {
        StringBuilder result = new StringBuilder();
        int i = 0;
        int n = s.length();
        while (i < n) {
            while (i < n && s.charAt(i) == ' ') {
                i++;
            }
            int start = i;
            while (i < n && s.charAt(i) != ' ') {
                i++;
            }
            int end = i - 1;
            while (end >= start) {
                result.append(s.charAt(end));
                end--;
            }
            while (i < n && s.charAt(i) == ' ') {
                result.append(' ');
                i++;
            }
        }
        return result.toString();
    }
}