class Solution {
    private int permutations(int n, int k) {
        if (k < 0 || k > n) {
            return 0;
        }
        int res = 1;
        for (int i = 0; i < k; i++) {
            res *= (n - i);
        }
        return res;
    }

    public int countSpecialIntegers(int n) {
        String s = String.valueOf(n);
        int len = s.length();
        int ans = 0;

        // Part 1: Count special integers with fewer digits than n.
        // For a k-digit number:
        // The first digit can be chosen from 1-9 (9 choices).
        // The remaining k-1 digits can be chosen from the remaining 9 distinct digits (0-9 excluding the first digit).
        for (int k = 1; k < len; k++) {
            ans += 9 * permutations(9, k - 1);
        }

        // Part 2: Count special integers with the same number of digits as n, and less than or equal to n.
        int usedMask = 0; // Bitmask to keep track of digits used in the current prefix.

        for (int i = 0; i < len; i++) {
            int currentDigit = s.charAt(i) - '0';

            // Iterate through possible digits 'j' for the current position 'i'.
            // 'j' must be less than 'currentDigit' (to count numbers strictly smaller than n with the same prefix).
            // If it's the first digit (i=0), 'j' cannot be 0.
            for (int j = (i == 0 ? 1 : 0); j < currentDigit; j++) {
                // If digit 'j' has not been used in the prefix so far
                if ((usedMask & (1 << j)) == 0) {
                    // We have fixed (i+1) digits (the prefix s[0...i-1] and digit 'j').
                    // We need to fill the remaining (len - 1 - i) positions.
                    // The number of available distinct digits for these positions is 10 - (i + 1).
                    ans += permutations(10 - (i + 1), len - 1 - i);
                }
            }

            // After considering digits smaller than 'currentDigit', now consider 'currentDigit' itself.
            // If 'currentDigit' has already been used in the prefix, then any number
            // starting with this prefix (s[0...i-1] + currentDigit) will have duplicate digits.
            // So, no more special integers can be formed with this prefix or any longer prefix.
            if ((usedMask & (1 << currentDigit)) != 0) {
                break; // Duplicate found, stop.
            }

            // Mark 'currentDigit' as used for the next iteration.
            usedMask |= (1 << currentDigit);

            // If we have successfully processed all digits of 'n' without finding duplicates,
            // it means 'n' itself is a special integer. Add 1 to the count.
            if (i == len - 1) {
                ans++;
            }
        }

        return ans;
    }
}