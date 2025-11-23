char findKthBit(int n, int k) {
    if (n == 1) {
        return '0';
    }

    int length_of_Sn_minus_1 = (1 << (n - 1)) - 1;
    int middle_index = length_of_Sn_minus_1 + 1; // 1-indexed position of the '1' in Sn

    if (k < middle_index) {
        // k is in the left part, which is Sn-1
        return findKthBit(n - 1, k);
    } else if (k == middle_index) {
        // k is the middle '1'
        return '1';
    } else {
        // k is in the right part, which is reverse(invert(Sn-1))
        // Calculate the corresponding 1-indexed position in the reversed string
        int k_in_reversed_inverted = k - middle_index;

        // Calculate the corresponding 1-indexed position in Sn-1
        // If X is a string of length L, the m-th char of reverse(X) is the (L - m + 1)-th char of X.
        int original_k_in_Sn_minus_1 = length_of_Sn_minus_1 - k_in_reversed_inverted + 1;

        // Get the bit from Sn-1
        char bit_from_Sn_minus_1 = findKthBit(n - 1, original_k_in_Sn_minus_1);

        // Invert the bit
        return (bit_from_Sn_minus_1 == '0' ? '1' : '0');
    }
}