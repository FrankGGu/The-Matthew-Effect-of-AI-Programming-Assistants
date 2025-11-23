class Solution {
    public int countTriplets(int[] arr) {
        int n = arr.length;
        int[] prefixXor = new int[n + 1];
        prefixXor[0] = 0;
        for (int i = 0; i < n; i++) {
            prefixXor[i + 1] = prefixXor[i] ^ arr[i];
        }

        int count = 0;
        // Iterate through all possible starting indices 'i' for the first array
        for (int i = 0; i < n; i++) {
            // Iterate through all possible ending indices 'k' for the second array
            // 'k' must be at least 'i+1' to allow for 'j' such that i < j <= k
            for (int k = i + 1; k < n; k++) {
                // The XOR sum of the subarray from arr[i] to arr[k] (inclusive)
                // can be calculated using prefix XOR sums: prefixXor[k+1] ^ prefixXor[i]
                // If this XOR sum is 0, it means arr[i] ^ ... ^ arr[k] == 0.
                // This implies that for any 'j' such that i < j <= k,
                // (arr[i] ^ ... ^ arr[j-1]) == (arr[j] ^ ... ^ arr[k]).
                if ((prefixXor[k + 1] ^ prefixXor[i]) == 0) {
                    // If the condition is met for a given (i, k) pair,
                    // any 'j' between i+1 and k (inclusive) will form a valid triplet.
                    // The number of such 'j' values is k - (i+1) + 1 = k - i.
                    count += (k - i);
                }
            }
        }
        return count;
    }
}