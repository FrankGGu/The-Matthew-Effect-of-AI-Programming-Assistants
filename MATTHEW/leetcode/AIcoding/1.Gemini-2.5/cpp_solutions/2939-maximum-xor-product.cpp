class Solution {
public:
    long long modular_multiply(long long a, long long b, long long m) {
        long long res = 0;
        a %= m;
        while (b > 0) {
            if (b & 1) {
                res = (res + a) % m;
            }
            a = (a * 2) % m;
            b >>= 1;
        }
        return res;
    }

    int maximumXorProduct(long long a, long long b, int n) {
        long long val_A = 0;
        long long val_B = 0;
        long long MOD = 1e9 + 7;

        for (int i = n - 1; i >= 0; --i) {
            long long bit_a = (a >> i) & 1;
            long long bit_b = (b >> i) & 1;

            if (bit_a == bit_b) {
                // If bits are the same, we want to set x_i such that (a^x)_i = 1 and (b^x)_i = 1.
                // This maximizes both numbers at this bit position.
                // To achieve this, x_i must be 1 - bit_a (or 1 - bit_b).
                val_A = (val_A << 1) | 1;
                val_B = (val_B << 1) | 1;
            } else { // bit_a != bit_b
                // If bits are different, we must make one (a^x)_i = 0 and the other (b^x)_i = 1 (or vice versa).
                // To maximize the product, we want to keep val_A and val_B as balanced as possible,
                // or make the currently smaller one larger.
                if (val_A <= val_B) {
                    // Try to make val_A get the 1, and val_B get the 0.
                    // This means (a^x)_i = 1 and (b^x)_i = 0.
                    // The x_i that achieves this is (1 - bit_a).
                    val_A = (val_A << 1) | 1;
                    val_B = (val_B << 1) | 0;
                } else { // val_A > val_B
                    // Try to make val_B get the 1, and val_A get the 0.
                    // This means (a^x)_i = 0 and (b^x)_i = 1.
                    // The x_i that achieves this is (1 - bit_b).
                    val_A = (val_A << 1) | 0;
                    val_B = (val_B << 1) | 1;
                }
            }
        }

        // For bits higher than n-1:
        // These bits are not affected by x (since 0 <= x < 2^n, x has at most n bits).
        // So for i >= n, x_i is effectively 0.
        // Therefore, (a^x)_i = a_i and (b^x)_i = b_i for i >= n.
        // We need to add these higher bits of 'a' and 'b' to our constructed val_A and val_B.
        // This is done by ORing the higher bits of 'a' and 'b' with the current val_A and val_B.
        // The mask `~((1LL << n) - 1)` isolates all bits from position `n` upwards.
        long long mask_higher_bits = (n == 64) ? -1LL : ~((1LL << n) - 1); // Handle n=64 edge case for mask
        val_A |= (a & mask_higher_bits);
        val_B |= (b & mask_higher_bits);

        return modular_multiply(val_A, val_B, MOD);
    }
};