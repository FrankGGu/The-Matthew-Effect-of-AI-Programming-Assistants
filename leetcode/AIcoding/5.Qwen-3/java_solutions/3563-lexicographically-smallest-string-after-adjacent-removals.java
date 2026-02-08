public class Solution {
    public String lexSmallestString(String s) {
        char[] chars = s.toCharArray();
        int n = chars.length;
        for (int i = 0; i < n - 1; i++) {
            if (chars[i] > chars[i + 1]) {
                char temp = chars[i];
                chars[i] = chars[i + 1];
                chars[i + 1] = temp;
                i = -1;
            }
        }
        return new String(chars);
    }
}