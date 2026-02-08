class Solution {
public:
    int countVowelPermutation(int n) {
        const int MOD = 1e9 + 7;
        long a = 1, e = 1, i = 1, o = 1, u = 1;

        for (int k = 2; k <= n; ++k) {
            long new_a = (e + i + u) % MOD;
            long new_e = (a + i) % MOD;
            long new_i = (e + o) % MOD;
            long new_o = i % MOD;
            long new_u = (i + o) % MOD;

            a = new_a;
            e = new_e;
            i = new_i;
            o = new_o;
            u = new_u;
        }

        return (a + e + i + o + u) % MOD;
    }
};