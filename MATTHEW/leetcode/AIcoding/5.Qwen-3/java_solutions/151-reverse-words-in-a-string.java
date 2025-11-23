public class Solution {
    public String reverseWords(String s) {
        StringBuilder result = new StringBuilder();
        int i = 0;
        int n = s.length();
        while (i < n) {
            while (i < n && s.charAt(i) == ' ') {
                i++;
            }
            if (i >= n) {
                break;
            }
            int j = i;
            while (j < n && s.charAt(j) != ' ') {
                j++;
            }
            String word = s.substring(i, j);
            if (result.length() > 0) {
                result.insert(0, word + " ");
            } else {
                result.insert(0, word);
            }
            i = j;
        }
        return result.toString();
    }
}