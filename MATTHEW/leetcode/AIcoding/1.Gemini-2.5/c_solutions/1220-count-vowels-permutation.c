#define MOD 1000000007

int countVowelPermutation(int n) {
    if (n == 0) {
        return 0;
    }

    // Initialize counts for strings of length 1
    // a_count represents the number of valid strings of current length ending with 'a'
    long long a_count = 1;
    long long e_count = 1;
    long long i_count = 1;
    long long o_count = 1;
    long long u_count = 1;

    // Iterate from length 2 up to n
    for (int k = 2; k <= n; ++k) {
        long long next_a_count, next_e_count, next_i_count, next_o_count, next_u_count;

        // A string of length k ending in 'a' can be formed by appending 'a' to a string of length k-1 ending in 'e', 'i', or 'u'.
        // ('e' can be followed by 'a', 'i' can be followed by 'a', 'u' can be followed by 'a')
        next_a_count = (e_count + i_count + u_count) % MOD;

        // A string of length k ending in 'e' can be formed by appending 'e' to a string of length k-1 ending in 'a' or 'i'.
        // ('a' can be followed by 'e', 'i' can be followed by 'e')
        next_e_count = (a_count + i_count) % MOD;

        // A string of length k ending in 'i' can be formed by appending 'i' to a string of length k-1 ending in 'e' or 'o'.
        // ('e' can be followed by 'i', 'o' can be followed by 'i')
        next_i_count = (e_count + o_count) % MOD;

        // A string of length k ending in 'o' can be formed by appending 'o' to a string of length k-1 ending in 'i'.
        // ('i' can be followed by 'o')
        next_o_count = (i_count) % MOD;

        // A string of length k ending in 'u' can be formed by appending 'u' to a string of length k-1 ending in 'i' or 'o'.
        // ('i' can be followed by 'u', 'o' can be followed by 'u')
        next_u_count = (i_count + o_count) % MOD;

        // Update counts for the current length k
        a_count = next_a_count;
        e_count = next_e_count;
        i_count = next_i_count;
        o_count = next_o_count;
        u_count = next_u_count;
    }

    // The total number of valid strings of length n is the sum of counts for all ending vowels
    long long total_count = (a_count + e_count + i_count + o_count + u_count) % MOD;

    return (int)total_count;
}