import java.util.*;

class Solution {
    public int hashDividedString(String s, int k) {
        int n = s.length();
        long hash = 0;
        long p = 31;
        long mod = 1000000007;
        long pPow = 1;

        for (int i = 0; i < k; i++) {
            hash = (hash + (s.charAt(k - 1 - i) - 'a' + 1) * pPow) % mod;
            if (i < k - 1) {
                pPow = (pPow * p) % mod;
            }
        }

        Set<Long> seen = new HashSet<>();
        seen.add(hash);
        int count = 1;

        for (int i = k; i < n; i++) {
            hash = (hash - (s.charAt(i - k) - 'a' + 1) + mod) % mod;
            hash = (hash * p) % mod;
            hash = (hash + (s.charAt(i) - 'a' + 1) * pPow) % mod;
            if (!seen.contains(hash)) {
                seen.add(hash);
                count++;
            }
        }

        return count;
    }
}