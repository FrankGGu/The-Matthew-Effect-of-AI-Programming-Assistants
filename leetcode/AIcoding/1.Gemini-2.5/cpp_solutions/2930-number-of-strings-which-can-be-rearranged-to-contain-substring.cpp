class Solution {
public:
    long long power(long long base, long long exp) {
        long long res = 1;
        long long MOD = 1000000007;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    int stringCount(int n) {
        long long MOD = 1000000007;

        // The problem asks for the number of strings of length n using characters 'a', 'b', 'c'
        // such that the string contains at least one 'a', at least one 'b', and at least one 'c'.
        // We use the principle of inclusion-exclusion.

        // Total strings of length n using 'a', 'b', 'c' is 3^n.
        long long total_strings = power(3, n);

        // Strings missing at least one character type:
        // Let S_a be strings missing 'a'.
        // Let S_b be strings missing 'b'.
        // Let S_c be strings missing 'c'.
        // We want to find Total - |S_a U S_b U S_c|.
        // |S_a U S_b U S_c| = (|S_a| + |S_b| + |S_c|)
        //                     - (|S_a intersect S_b| + |S_a intersect S_c| + |S_b intersect S_c|)
        //                     + (|S_a intersect S_b intersect S_c|)

        // 1. Sum of sizes of single sets:
        // Strings missing 'a' (use only 'b', 'c'): 2^n ways.
        // Strings missing 'b' (use only 'a', 'c'): 2^n ways.
        // Strings missing 'c' (use only 'a', 'b'): 2^n ways.
        // Sum = 3 * 2^n.
        long long sum_single_missing = (3 * power(2, n)) % MOD;

        // 2. Sum of sizes of double intersections:
        // Strings missing 'a' and 'b' (use only 'c'): 1^n = 1 way.
        // Strings missing 'a' and 'c' (use only 'b'): 1^n = 1 way.
        // Strings missing 'b' and 'c' (use only 'a'): 1^n = 1 way.
        // Sum = 3 * 1^n = 3.
        long long sum_double_