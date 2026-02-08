class Solution {
    public int minBitChanges(int n, int k) {
        // If k has a bit set (1) at a position where n has a 0,
        // it's impossible to make n equal to k by only changing 1s to 0s in n.
        // This condition can be checked by (n & k) == k.
        // If (n & k) != k, it means there's at least one bit position where k has a 1
        // but n has a 0, which violates the rule.
        if ((n & k) != k) {
            return -1;
        }

        // If it's possible, we need to count the number of bits that are 1 in n
        // and 0 in k. These are the bits that must be changed.
        // The XOR operation (n ^ k) will have a 1 at positions where n and k differ.
        // Since we've already established that if k has a 1, n must also have a 1
        // (due to the (n & k) == k check), any differing bit must mean n has a 1
        // and k has a 0.
        // Therefore, we just need to count the set bits in (n ^ k).
        int xorResult = n ^ k;
        int count = 0;

        // Count set bits using Brian Kernighan's algorithm
        while (xorResult > 0) {
            xorResult &= (xorResult - 1);
            count++;
        }

        return count;
    }
}