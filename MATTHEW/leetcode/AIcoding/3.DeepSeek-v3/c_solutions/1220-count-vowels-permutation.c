int countVowelPermutation(int n) {
    if (n == 0) return 0;

    long mod = 1000000007;
    long a = 1, e = 1, i = 1, o = 1, u = 1;

    for (int j = 1; j < n; j++) {
        long a_next = e;
        long e_next = (a + i) % mod;
        long i_next = (a + e + o + u) % mod;
        long o_next = (i + u) % mod;
        long u_next = a;

        a = a_next;
        e = e_next;
        i = i_next;
        o = o_next;
        u = u_next;
    }

    return (a + e + i + o + u) % mod;
}