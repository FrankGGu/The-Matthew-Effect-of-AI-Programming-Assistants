class Solution {
    public int minimumOneBitOperations(int n) {
        int ans = 0;
        int sign = 1; 

        while (n > 0) {
            // Find the position of the most significant bit (MSB) of n.
            // For example, if n=13 (1101_2), k=3 (2^3=8).
            // Integer.numberOfLeadingZeros(n) returns the number of zero bits 
            // preceding the highest-order ("most significant") one-bit in the binary representation of n.
            // For a 32-bit int, 31 - numberOfLeadingZeros(n) gives the 0-indexed position of the MSB.
            int k = 31 - Integer.numberOfLeadingZeros(n);

            // Calculate the number of operations for this MSB component.
            // The value is (2^(k+1) - 1).
            // This can be computed as (1 << (k + 1)) - 1.
            ans += sign * ((1 << (k + 1)) - 1);

            // Remove the MSB from n to process the remaining bits in the next iteration.
            // This is equivalent to n = n - 2^k.
            n -= (1 << k);

            // Alternate the sign for the next term in the sum.
            // This corresponds to the recursive relation: f(n) = (2^(k+1) - 1) - f(n - 2^k).
            sign = -sign;
        }

        return ans;
    }
}