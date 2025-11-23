class Solution {
    public boolean isAdditiveNumber(String num) {
        int n = num.length();
        // i represents the length of the first number
        // The first number cannot be longer than half the total string length
        // to leave enough space for at least two more numbers (each at least length 1).
        // A tighter bound for `i` is `n - 2` to ensure `num2` and `num3` can exist.
        // However, `i <= n/2` is a common optimization and generally sufficient.
        for (int i = 1; i <= n / 2; i++) {
            // Check for leading zeros for the first number
            // A number cannot have leading zeros unless it is the number 0 itself.
            if (num.charAt(0) == '0' && i > 1) {
                break; // If the first number has a leading zero and is not "0", it's invalid.
                       // Any longer first number starting with '0' would also be invalid.
            }

            long num1 = Long.parseLong(num.substring(0, i));

            // j represents the end index of the second number.
            // The second number starts at index `i` and ends at `j-1`. Its length is `j-i`.
            // The second number must also leave at least one character for the third number (the sum).
            // So, `j` must be less than `n`.
            // Also, `j` must be at least `i + 1` (second number has length at least 1).
            for (int j = i + 1; j < n; j++) {
                // Check for leading zeros for the second number
                // `num.substring(i, j)` is the second number. Its length is `j - i`.
                if (num.charAt(i) == '0' && j - i > 1) {
                    break; // If the second number has a leading zero and is not "0", it's invalid.
                           // Any longer second number starting at `i` would also be invalid.
                }

                long num2 = Long.parseLong(num.substring(i, j));

                // Start the recursive check from the end of the second number.
                if (check(num1, num2, j, num)) {
                    return true; // Found an additive sequence
                }
            }
        }
        return false; // No additive sequence found
    }

    // Helper function to recursively check if the rest of the string forms an additive sequence
    private boolean check(long prev1, long prev2, int startIndex, String s) {
        // Base case: If we have successfully parsed the entire string, it's an additive sequence.
        if (startIndex == s.length()) {
            return true;
        }

        long sum = prev1 + prev2;
        String sumStr = String.valueOf(sum);

        // Check if the remaining string `s` from `startIndex` starts with the calculated `sumStr`.
        // `s.startsWith(prefix, toffset)` checks if the substring of `s` beginning at `toffset` starts with `prefix`.
        if (!s.startsWith(sumStr, startIndex)) {
            return false;
        }

        // Recursively call with `prev2` as the new `prev1`, `sum` as the new `prev2`,
        // and update `startIndex` by the length of the `sumStr`.
        return check(prev2, sum, startIndex + sumStr.length(), s);
    }
}