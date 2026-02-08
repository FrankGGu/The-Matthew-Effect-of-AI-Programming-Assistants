class Solution {
    public int maxXorProduct(long a, long b, int n) {
        long MOD = 1_000_000_007L;

        long valA = 0;
        long valB = 0;

        // Iterate from the most significant bit (n-1) down to the least significant bit (0).
        for (int i = n - 1; i >= 0; i--) {
            long bitA = (a >> i) & 1;
            long bitB = (b >> i) & 1;

            if (bitA == bitB) {
                // If the i-th bits of 'a' and 'b' are the same,
                // we want to choose x_i such that both (a XOR x)_i and (b XOR x)_i are 1.
                // This means x_i should be (1 - bitA).
                // This choice makes both numbers larger at this bit position, which is always optimal.
                valA = (valA * 2 + 1) % MOD;
                valB = (valB * 2 + 1) % MOD;
            } else { // bitA != bitB
                // If the i-th bits of 'a' and 'b' are different,
                // we cannot make both (a XOR x)_i and (b XOR x)_i equal to 1.
                // One will be 0 and the other will be 1.
                // To maximize the product, we want to keep valA and valB as close to each other as possible.
                // So, we assign '1' to the number that is currently smaller (or equal) and '0' to the other.
                if (valA <= valB) {
                    // We want (a XOR x)_i = 1 and (b XOR x)_i = 0.
                    // To achieve (a XOR x)_i = 1, x_i must be (1 - bitA).
                    // To achieve (b XOR x)_i = 0, x_i must be bitB.
                    // Since bitA != bitB, (1 - bitA) is equal to bitB. So, we choose x_i = bitB.
                    valA = (valA * 2 + 1) % MOD; // (a XOR x)_i becomes 1
                    valB = (valB * 2 + 0) % MOD; // (b XOR x)_i becomes 0
                } else { // valA > valB
                    // We want (a XOR x)_i = 0 and (b XOR x)_i = 1.
                    // To achieve (a XOR x)_i = 0, x_i must be bitA.
                    // To achieve (b XOR x)_i = 1, x_i must be (1 - bitB).
                    // Since bitA != bitB, bitA is equal to (1 - bitB). So, we choose x_i = bitA.
                    valA = (valA * 2 + 0) % MOD; // (a XOR x)_i becomes 0
                    valB = (valB * 2 + 1) % MOD; // (b XOR x)_i becomes 1
                }
            }
        }

        // The final product should also be modulo MOD.
        return (int) ((valA * valB) % MOD);
    }
}