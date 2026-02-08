class Solution {
    public char findKthCharacter(int n, long k) {
        // The initial string s = "b" at step 0.
        // For each step from 1 to n, s = s_prev + reverse(invert(s_prev)).
        // 'invert' replaces 'a' with 'b' and 'b' with 'a'.
        // 'reverse' reverses the string.

        // We need to find the k-th character (1-indexed) after n steps.

        // `invertedFromBase` tracks the parity of inversions.
        // If `invertedFromBase` is true, it means the character we eventually find at S_0[1]
        // has been inverted an odd number of times, so its final value should be 'a' (invert of 'b').
        // If `invertedFromBase` is false, it means it has been inverted an even number of times,
        // so its final value should be 'b' (original 'b').
        boolean invertedFromBase = false; 

        // We simulate going backwards from S_n to S_0
        while (n > 0) {
            long lengthOfPrevString = 1L << (n - 1); // Length of S_{n-1}

            if (k <= lengthOfPrevString) {
                // The k-th character is in the first half (S_{n-1}).
                // Its state (inverted or not) relative to its parent string S_{n-1} is unchanged.
                n--;
            } else {
                // The k-th character is in the second half (reverse(invert(S_{n-1}))).
                // This means the character we are looking for is inverted relative to the corresponding
                // character in S_{n-1}. So, we toggle the `invertedFromBase` flag.
                invertedFromBase = !invertedFromBase;

                // Now, we need to find the corresponding k in S_{n-1}.
                // The k-th character in S_n (1-indexed) is the (k - lengthOfPrevString)-th character
                // in reverse(invert(S_{n-1})).
                // Let k_offset = k - lengthOfPrevString. This is the 1-indexed position within the second half.
                // The k_offset-th character in reverse(X) is the (length(X) - k_offset + 1)-th character in X.
                // Here X = invert(S_{n-1}), and length(X) = lengthOfPrevString.
                // So, the new k for S_{n-1} is:
                k = lengthOfPrevString - (k - lengthOfPrevString) + 1;
                n--;
            }
        }

        // After the loop, n is 0. The base string is "b".
        // The `k` value will always be 1 at this point due to the transformation logic.
        // So we are looking for S_0[1] which is 'b'.
        // We apply the total inversion parity tracked by `invertedFromBase`.
        if (invertedFromBase) {
            // Original 'b' inverted an odd number of times -> 'a'
            return 'a';
        } else {
            // Original 'b' inverted an even number of times -> 'b'
            return 'b';
        }
    }
}