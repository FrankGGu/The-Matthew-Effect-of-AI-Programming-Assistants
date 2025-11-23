class Solution {
    public int[] solve(int c, int d) {
        // Let a = x AND y
        // Let b = x XOR y

        // We are given:
        // x NAND y = c  => NOT (x AND y) = c
        // x XOR y = d   => b = d

        // Interpretation of NOT (x AND y) = c:
        // Since x, y, and c are non-negative, x AND y is also non-negative.
        // In Java, the bitwise complement operator '~' on an int can produce a negative result
        // (e.g., ~0 is -1). However, c is specified as non-negative.
        // This implies that the 'NOT' operation is effectively a bitwise complement over the
        // non-negative range, typically by masking the result with Integer.MAX_VALUE (0x7FFFFFFF).
        // So, if NOT (x AND y) = c, then (x AND y) = (~c) & Integer.MAX_VALUE.

        int a = (~c) & Integer.MAX_VALUE; // This represents x AND y
        int b = d;                       // This represents x XOR y

        // Consistency check:
        // For any bit position i, if the i-th bit of (x XOR y) is 1, then the i-th bit of (x AND y) must be 0.
        // This is because if x_i XOR y_i = 1, then x_i and y_i are different (0,1 or 1,0),
        // which implies x_i AND y_i = 0.
        // Therefore, (a AND b) must be 0. If it's not, no solution exists.
        if ((a & b) != 0) {
            return new int[]{-1, -1};
        }

        // If (a AND b) == 0, a solution exists.
        // We need to find x and y such that:
        // 1. x AND y = a
        // 2. x XOR y = b

        // We can construct a pair (x, y) that satisfies these conditions.
        // Consider the properties of bitwise operations when (a AND b) = 0:
        // If a & b = 0, then a | b = a ^ b.
        // Let's propose a solution:
        // x = a | b
        // y = a

        // Let's verify this proposed solution:
        // 1. Check x AND y:
        //    (a | b) AND a
        //    Since a & b = 0, the bits set in 'a' and 'b' are disjoint.
        //    Therefore, (a | b) AND a = a. (This condition is satisfied)

        // 2. Check x XOR y:
        //    (a | b) XOR a
        //    Since a & b = 0, we can replace (a | b) with (a ^ b).
        //    So, (a ^ b) XOR a = b. (This condition is satisfied)

        // Both x = a | b and y = a will be non-negative because:
        // - 'a' is constructed using `& Integer.MAX_VALUE`, making it non-negative.
        // - 'b' is 'd', which is given as non-negative.
        // - The bitwise OR of two non-negative numbers (a | b) is also non-negative.

        return new int[]{a | b, a};
    }
}