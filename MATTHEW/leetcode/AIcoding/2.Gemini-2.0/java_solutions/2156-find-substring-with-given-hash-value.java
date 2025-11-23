class Solution {
    public String subStrHash(String s, int power, int modulo, int k, int hashValue) {
        int n = s.length();
        long[] p = new long[n + 1];
        p[0] = 1;
        for (int i = 1; i <= n; i++) {
            p[i] = (p[i - 1] * power) % modulo;
        }

        long hash = 0;
        for (int i = n - k; i < n; i++) {
            hash = (hash * power + (s.charAt(i) - 'a' + 1)) % modulo;
        }

        int ans = n - k;
        if (hash == hashValue) {
            return s.substring(ans, n);
        }

        for (int i = n - k - 1; i >= 0; i--) {
            hash = (hash - (s.charAt(i + k) - 'a' + 1) * p[k - 1] % modulo + modulo) % modulo;
            hash = (hash * power + (s.charAt(i) - 'a' + 1)) % modulo;
            if (hash == hashValue) {
                ans = i;
            }
        }

        return s.substring(ans, ans + k);
    }
}