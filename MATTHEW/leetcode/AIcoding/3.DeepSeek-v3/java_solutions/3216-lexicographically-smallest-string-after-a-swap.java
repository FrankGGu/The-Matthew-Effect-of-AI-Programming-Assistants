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
        int j = i;
        while (j < n && chars[j] != 'a') {
            chars[j] = (char)(chars[j] - 1);
            j++;
        }
        return new String(chars);
    }
}