class Solution {
    public String subStrHash(String s, int power, int modulo, int k, int hashValue) {
        int n = s.length();
        long[] powerK = new long[k];
        powerK[0] = 1;
        for (int i = 1; i < k; i++) {
            powerK[i] = (powerK[i - 1] * power) % modulo;
        }

        long hash = 0;
        int res = 0;

        for (int i = n - 1; i >= 0; i--) {
            hash = (hash * power + (s.charAt(i) - 'a' + 1)) % modulo;
            if (i + k < n) {
                hash = (hash - (s.charAt(i + k) - 'a' + 1) * powerK[k - 1] % modulo + modulo) % modulo;
            }
            if (hash == hashValue) {
                res = i;
            }
        }

        return s.substring(res, res + k);
    }
}