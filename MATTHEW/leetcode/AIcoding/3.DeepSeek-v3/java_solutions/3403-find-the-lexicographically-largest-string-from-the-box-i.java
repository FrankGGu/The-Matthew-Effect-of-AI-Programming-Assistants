class Solution {
    public String maximumString(String s) {
        char[] chars = s.toCharArray();
        int n = chars.length;
        for (int i = 0; i < n; i++) {
            if (chars[i] == '?') {
                char prev = (i == 0) ? 'a' : chars[i - 1];
                char next = (i == n - 1) ? 'z' : chars[i + 1];
                char max = 'a';
                if (prev != 'a' && next != 'a') {
                    max = 'a';
                } else {
                    max = 'b';
                    if (prev == 'b' || next == 'b') {
                        max = 'c';
                    }
                }
                chars[i] = max;
            }
        }
        return new String(chars);
    }
}