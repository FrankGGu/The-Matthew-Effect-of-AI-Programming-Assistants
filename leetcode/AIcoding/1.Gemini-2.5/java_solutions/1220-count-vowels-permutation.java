class Solution {
    public int countVowelPermutation(int n) {
        long MOD = 1_000_000_007;

        long a_count = 1;
        long e_count = 1;
        long i_count = 1;
        long o_count = 1;
        long u_count = 1;

        for (int k = 2; k <= n; k++) {
            long next_a_count;
            long next_e_count;
            long next_i_count;
            long next_o_count;
            long next_u_count;

            // 'a' can be preceded by 'e', 'i', 'u'
            next_a_count = (e_count + i_count + u_count) % MOD;

            // 'e' can be preceded by 'a', 'i'
            next_e_count = (a_count + i_count) % MOD;

            // 'i' can be preceded by 'e', 'o'
            next_i_count = (e_count + o_count) % MOD;

            // 'o' can be preceded by 'i'
            next_o_count = i_count % MOD;

            // 'u' can be preceded by 'i', 'o'
            next_u_count = (i_count + o_count) % MOD;

            a_count = next_a_count;
            e_count = next_e_count;
            i_count = next_i_count;
            o_count = next_o_count;
            u_count = next_u_count;
        }

        long total_count = (a_count + e_count + i_count + o_count + u_count) % MOD;
        return (int) total_count;
    }
}