class Solution {
    public String smallestString(String s) {
        char[] chars = s.toCharArray();
        int n = chars.length;
        int i = 0;
        while (i < n && chars[i] == 'a') {
            i++;
        }
        if (i == n) {
            chars[n - 1] = 'z';
            return new String(chars);
        }
        while (i < n && chars[i] != 'a') {
            chars[i] = (char) (chars[i] - 1);
            i++;
        }
        return new String(chars);
    }
}