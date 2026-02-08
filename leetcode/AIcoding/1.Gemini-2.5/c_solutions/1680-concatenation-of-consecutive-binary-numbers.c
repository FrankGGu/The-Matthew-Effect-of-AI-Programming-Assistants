long long concatenatedBinary(int n) {
    long long ans = 0;
    int len = 0; // Represents the number of bits for the current number i
    long long MOD = 1000000007;

    for (int i = 1; i <= n; i++) {
        // If 'i' is a power of 2, its binary representation will have one more bit
        // than the numbers just before it. For example:
        // 1 (1 bit)
        // 2 (10, 2 bits)
        // 3 (11, 2 bits)
        // 4 (100, 3 bits)
        // We check if 'i' is a power of 2 using the bitwise trick: i & (i - 1) == 0
        if ((i & (i - 1)) == 0) {
            len++;
        }

        // Shift the current accumulated answer 'ans' by 'len' bits to the left.
        // This makes space for the binary representation of the current number 'i'.
        // Then, add 'i' to the shifted result.
        // Apply modulo operation at each step to prevent overflow.
        ans = ((ans << len) % MOD + i) % MOD;
    }

    return ans;
}