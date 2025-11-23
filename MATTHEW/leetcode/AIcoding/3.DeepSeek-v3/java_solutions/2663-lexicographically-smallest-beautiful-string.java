class Solution {
    public String smallestBeautifulString(String s, int k) {
        char[] chars = s.toCharArray();
        int n = chars.length;
        for (int i = n - 1; i >= 0; --i) {
            for (char c = (char) (chars[i] + 1); c < 'a' + k; ++c) {
                if ((i >= 1 && c == chars[i - 1]) || (i >= 2 && c == chars[i - 2])) {
                    continue;
                }
                chars[i] = c;
                for (int j = i + 1; j < n; ++j) {
                    for (char d = 'a'; d < 'a' + k; ++d) {
                        if ((j >= 1 && d == chars[j - 1]) || (j >= 2 && d == chars[j - 2])) {
                            continue;
                        }
                        chars[j] = d;
                        break;
                    }
                }
                return new String(chars);
            }
        }
        return "";
    }
}