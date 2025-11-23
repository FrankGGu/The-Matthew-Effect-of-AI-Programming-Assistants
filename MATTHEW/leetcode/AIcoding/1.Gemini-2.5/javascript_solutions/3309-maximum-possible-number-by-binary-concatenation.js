var concatenatedBinary = function(n) {
    let ans = 0;
    let len = 0; // Current bit length of the number i
    const MOD = 1000000007;

    for (let i = 1; i <= n; i++) {
        // If i is a power of 2, then its binary representation requires one more bit
        // For example, 1 (1 bit), 2 (2 bits), 4 (3 bits), 8 (4 bits)
        // This condition checks if i is a power of 2: i & (i - 1) will be 0
        if ((i & (i - 1)) === 0) {
            len++;
        }

        // The formula for concatenating a new number 'i' is:
        // (previous_concatenated_value * 2^len + i) % MOD
        // Where 2^len is equivalent to (1 << len)
        ans = ((ans << len) | i) % MOD;
        // The above line `((ans << len) | i)` is a shortcut for `(ans * (1 << len) + i)`.
        // It relies on the fact that `ans` is already a number whose binary
        // representation is the concatenation of `1` to `i-1`.
        // Left-shifting `ans` by `len` bits effectively appends `len` zeros to its right.
        // Then, a bitwise OR with `i` fills those `len` zeros with the binary representation of `i`.
        // This works because `i` will always fit within `len` bits (by definition of `len`),
        // and `i` will effectively be "appended" to the shifted `ans`.
    }

    return ans;
};