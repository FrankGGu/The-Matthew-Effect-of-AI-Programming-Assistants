public class Solution {
    public int countVowelPermutation(int n) {
        long a = 1, e = 1, i = 1, o = 1, u = 1;
        int mod = (int) (1e9 + 7);

        for (int j = 1; j < n; j++) {
            long newA = (e + i + u) % mod;
            long newE = (a + i) % mod;
            long newI = (e + o) % mod;
            long newO = (i) % mod;
            long newU = (i + o) % mod;

            a = newA;
            e = newE;
            i = newI;
            o = newO;
            u = newU;
        }

        return (int) ((a + e + i + o + u) % mod);
    }
}