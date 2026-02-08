import java.util.Arrays;

class Solution {
    public String maximumBinaryString(String binary) {
        int n = binary.length();
        int count0 = 0;
        for (char c : binary.toCharArray()) {
            if (c == '0') {
                count0++;
            }
        }

        if (count0 == 0) {
            return binary;
        }

        char[] result = new char[n];
        Arrays.fill(result, '1');

        // The '10' -> '01' operation allows any '0' to move left past any '1'.
        // This means all '0's can be grouped together at the beginning of the string.
        // For example, "1010" can become "0011".
        // After this, the string will be `count0` zeros followed by `n - count0` ones.
        // Example: "00...0" (count0 times) + "11...1" (n - count0 times).

        // The '00' -> '10' operation converts two adjacent '0's into '10'.
        // This means if we have `count0` leading zeros, we can convert `count0 - 1` of them into '1's.
        // For example, "0000" can become "1110".
        // So, `0...0` (count0 times) becomes `1...10` (count0 - 1 ones, then one zero).

        // Combining these:
        // 1. First, conceptually move all '0's to the left: `0...0` (`count0` times) `1...1` (`n - count0` times).
        // 2. Then, apply '00' -> '10' to the leading `count0` zeros. This converts `count0 - 1` zeros to ones.
        //    The result is `1...1` (`count0 - 1` times) `0` `1...1` (`n - count0` times).
        // The single remaining '0' will be at index `count0 - 1`.

        result[count0 - 1] = '0';

        return new String(result);
    }
}