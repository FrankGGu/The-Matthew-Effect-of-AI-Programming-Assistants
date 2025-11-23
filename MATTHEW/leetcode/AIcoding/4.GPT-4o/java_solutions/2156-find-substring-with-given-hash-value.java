class Solution {
    public String subStrHash(String s, int k, int hashValue) {
        int n = s.length();
        long base = 1, currentHash = 0;

        for (int i = 0; i < k; i++) {
            currentHash = (currentHash * 26 + (s.charAt(i) - 'a' + 1)) % 1000000007;
            if (i < k - 1) base = (base * 26) % 1000000007;
        }

        if (currentHash == hashValue) return s.substring(0, k);

        for (int i = k; i < n; i++) {
            currentHash = (currentHash * 26 - (s.charAt(i - k) - 'a' + 1) * base % 1000000007 + 1000000007) % 1000000007;
            currentHash = (currentHash + (s.charAt(i) - 'a' + 1)) % 1000000007;

            if (currentHash == hashValue) {
                return s.substring(i - k + 1, i + 1);
            }
        }

        return "";
    }
}