#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<int> decode(std::vector<int>& encoded) {
        int n = encoded.size() + 1;

        // Calculate the XOR sum of all numbers from 1 to n.
        // This is P_total = perm[0] ^ perm[1] ^ ... ^ perm[n-1].
        int total_xor_1_to_n = 0;
        for (int i = 1; i <= n; ++i) {
            total_xor_1_to_n ^= i;
        }

        // Calculate the XOR sum of perm[1] ^ perm[2] ^ ... ^ perm[n-1].
        // We know encoded[i] = perm[i] ^ perm[i+1].
        // Consider (perm[1] ^ perm[2]) ^ (perm[3] ^ perm[4]) ^ ... ^ (perm[n-2] ^ perm[n-1]).
        // Since n is odd, n-1 is even, so n-2 is odd.
        // The last term will be perm[n-2] ^ perm[n-1], which is encoded[n-2].
        // This sum simplifies to perm[1] ^ perm[2] ^ ... ^ perm[n-1].
        // This is equivalent to encoded[1] ^ encoded[3] ^ ... ^ encoded[n-2].
        int xor_of_p1_to_pn_minus_1 = 0;
        for (int i = 1; i < encoded.size(); i += 2) {
            xor_of_p1_to_pn_minus_1 ^= encoded[i];
        }

        // We have:
        // total_xor_1_to_n = perm[0] ^ (perm[1] ^ perm[2] ^ ... ^ perm[n-1])
        // total_xor_1_to_n = perm[0] ^ xor_of_p1_to_pn_minus_1
        // Therefore, perm[0] = total_xor_1_to_n ^ xor_of_p1_to_pn_minus_1
        int p0 = total_xor_1_to_n ^ xor_of_p1_to_pn_minus_1;

        // Reconstruct the entire perm array.
        std::vector<int> perm(n);
        perm[0] = p0;
        for (int i = 0; i < n - 1; ++i) {
            // perm[i+1] = perm[i] ^ encoded[i]
            perm[i+1] = perm[i] ^ encoded[i];
        }

        return perm;
    }
};