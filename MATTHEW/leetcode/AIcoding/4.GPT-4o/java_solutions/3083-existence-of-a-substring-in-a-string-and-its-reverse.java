class Solution {
    public boolean checkSubstring(String str) {
        int n = str.length();
        for (int len = 1; len <= n / 2; len++) {
            for (int i = 0; i <= n - len; i++) {
                String sub = str.substring(i, i + len);
                String rev = new StringBuilder(sub).reverse().toString();
                if (str.contains(rev)) {
                    return true;
                }
            }
        }
        return false;
    }
}