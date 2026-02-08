class Solution {
public:
    int concatenatedBinary(int n) {
        long long ans = 0;
        long long MOD = 1e9 + 7;
        int num_bits = 0; // Stores the number of bits for the current integer i

        for (int i = 1; i <= n; ++i) {
            // Check if i is a power of 2. If it is, the number of bits required to represent
            // numbers increases. For example, 1 needs 1 bit, 2 needs 2 bits, 4 needs 3 bits.
            // All numbers from 2^k to 2^(k+1)-1 require k+1 bits.
            // The condition `(i & (i - 1)) == 0` is true if i is a power of 2 (for i > 0).
            if ((i & (i - 1)) == 0) {
                num_bits++;
            }

            // To append the binary representation of 'i' to 'ans', we effectively
            // shift 'ans' left by 'num_bits' positions and then OR 'i'.
            // This is equivalent to `ans = (ans * 2^num_bits) + i`.
            // We must apply modulo at each step to prevent overflow.
            ans = ((ans << num_bits) % MOD + i) % MOD;
        }

        return ans;
    }
};