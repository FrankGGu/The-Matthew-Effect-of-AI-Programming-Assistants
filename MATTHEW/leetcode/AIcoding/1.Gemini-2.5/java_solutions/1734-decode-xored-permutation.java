class Solution {
    public int[] decode(int[] encoded) {
        int n = encoded.length + 1;

        // Step 1: Calculate the XOR sum of all numbers from 1 to n (P_xor)
        // P_xor = perm[0] ^ perm[1] ^ ... ^ perm[n-1]
        int totalXorSum = 0;
        for (int i = 1; i <= n; i++) {
            totalXorSum ^= i;
        }

        // Step 2: Calculate the XOR sum of perm[1] ^ perm[2] ^ ... ^ perm[n-1]
        // We know encoded[i] = perm[i] ^ perm[i+1]
        // Consider encoded[1] ^ encoded[3] ^ ... ^ encoded[n-2]
        // Since n is odd, n-2 is odd.
        // This sum will be (perm[1]^perm[2]) ^ (perm[3]^perm[4]) ^ ... ^ (perm[n-2]^perm[n-1])
        // which simplifies to perm[1] ^ perm[2] ^ ... ^ perm[n-1]
        int xorSumExcludingP0 = 0;
        for (int i = 1; i < encoded.length; i += 2) { // Iterate over odd indices of encoded array
            xorSumExcludingP0 ^= encoded[i];
        }

        // Step 3: Calculate perm[0]
        // totalXorSum = perm[0] ^ (perm[1] ^ perm[2] ^ ... ^ perm[n-1])
        // totalXorSum = perm[0] ^ xorSumExcludingP0
        // Therefore, perm[0] = totalXorSum ^ xorSumExcludingP0
        int[] perm = new int[n];
        perm[0] = totalXorSum ^ xorSumExcludingP0;

        // Step 4: Decode the rest of the permutation
        // perm[i+1] = perm[i] ^ encoded[i]
        for (int i = 0; i < encoded.length; i++) {
            perm[i+1] = perm[i] ^ encoded[i];
        }

        return perm;
    }
}