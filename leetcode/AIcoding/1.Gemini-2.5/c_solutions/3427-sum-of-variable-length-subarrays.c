int sumOddLengthSubarrays(int* arr, int arrSize) {
    int totalSum = 0;
    for (int k = 0; k < arrSize; k++) {
        // Calculate count of even/odd indices for start 'i' in range [0, k]
        // Indices for 'i': 0, 1, ..., k
        // Total 'k + 1' choices for 'i'
        int count_i_even = (k / 2) + 1; // Number of even indices in 0..k
        int count_i_odd = (k + 1) / 2;   // Number of odd indices in 0..k

        // Calculate count of even/odd indices for end 'j' in range [k, arrSize - 1]
        // Indices for 'j': k, k+1, ..., arrSize-1
        // Total 'arrSize - k' choices for 'j'
        int num_right = arrSize - k;
        int count_j_even;
        int count_j_odd;

        if (k % 2 == 0) { // If k is even, the sequence k, k+1, ... starts with an even number
            count_j_even = (num_right + 1) / 2;
            count_j_odd = num_right / 2;
        } else { // If k is odd, the sequence k, k+1, ... starts with an odd number
            count_j_even = num_right / 2;
            count_j_odd = (num_right + 1) / 2;
        }

        // An odd-length subarray arr[i...j] has length (j - i + 1) which is odd.
        // This means (j - i) must be an even number.
        // For (j - i) to be even, 'i' and 'j' must have the same parity.
        // So, we sum (count of even 'i' * count of even 'j') + (count of odd 'i' * count of odd 'j')
        int occurrences = count_i_even * count_j_even + count_i_odd * count_j_odd;
        totalSum += arr[k] * occurrences;
    }
    return totalSum;
}