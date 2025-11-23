public class Solution {
    public String compressString(String message) {
        StringBuilder result = new StringBuilder();
        int n = message.length();
        for (int i = 0; i < n; i++) {
            char c = message.charAt(i);
            int count = 1;
            while (i + 1 < n && message.charAt(i + 1) == c) {
                count++;
                i++;
            }
            result.append(c).append(count);
        }
        return result.toString();
    }
}