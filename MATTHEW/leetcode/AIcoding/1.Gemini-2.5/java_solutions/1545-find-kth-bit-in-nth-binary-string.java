class Solution {
    public char findKthBit(int n, int k) {
        if (n == 1) {
            return '0';
        }

        int mid = 1 << (n - 1); // Length of S_n-1 + 1, which is the index of the middle '1'

        if (k == mid) {
            return '1';
        } else if (k < mid) {
            return findKthBit(n - 1, k);
        } else { // k > mid
            // The position k is in the reversed and inverted part.
            // Its 1-indexed position within this segment is k - mid.
            // The length of S_{n-1} is (2^(n-1)) - 1 = mid - 1.
            // To find the corresponding 1-indexed position in S_{n-1} before inversion and reversal:
            // It's (length of S_{n-1}) - (k - mid) + 1
            // = (mid - 1) - (k - mid) + 1
            // = mid - 1 - k + mid + 1
            // = 2 * mid - k
            // Since mid = 2^(n-1), 2 * mid = 2 * 2^(n-1) = 2^n.
            // So the corresponding index in S_{n-1} is 2^n - k.
            char bit = findKthBit(n - 1, (1 << n) - k);
            return (bit == '0') ? '1' : '0';
        }
    }
}