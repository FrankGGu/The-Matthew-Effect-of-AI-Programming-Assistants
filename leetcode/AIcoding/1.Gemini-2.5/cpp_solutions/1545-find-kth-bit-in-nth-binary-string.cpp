class Solution {
public:
    char findKthBit(int n, int k) {
        if (n == 1) {
            return '0';
        }

        // Calculate the length of S_{n-1} + 1, which is also 2^(n-1).
        // This 'mid' value represents the 1-indexed position of the middle '1' character in S_n.
        long long mid = 1LL << (n - 1); 

        if (k < mid) {
            // If k is in the first part (S_{n-1}), recursively find the k-th bit in S_{n-1}.
            return findKthBit(n - 1, k);
        } else if (k == mid) {
            // If k is at the middle position, it's always '1'.
            return '1';
        } else {
            // If k is in the third part (reverse(invert(S_{n-1}))),
            // we need to find its corresponding position in S_{n-1} and invert the bit.

            // The length of S_n is (2^n - 1).
            // The k-th bit in S_n corresponds to the (2^n - k)-th bit in S_{n-1}
            // before inversion and reversal.
            char bit = findKthBit(n - 1, (1LL << n) - k);

            // Invert the found bit.
            return (bit == '0' ? '1' : '0');
        }
    }
};