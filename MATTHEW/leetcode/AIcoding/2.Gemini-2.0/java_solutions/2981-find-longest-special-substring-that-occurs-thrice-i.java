class Solution {
    public int longestSpecialSubstring(String s) {
        int n = s.length();
        int ans = -1;
        for (int len = 1; len <= n / 3; len++) {
            for (int i = 0; i <= n - len; i++) {
                String sub = s.substring(i, i + len);
                int count = 0;
                for (int j = 0; j <= n - len; j++) {
                    if (s.substring(j, j + len).equals(sub)) {
                        count++;
                    }
                }
                if (count >= 3) {
                    ans = len;
                }
            }
        }
        return ans;
    }
}