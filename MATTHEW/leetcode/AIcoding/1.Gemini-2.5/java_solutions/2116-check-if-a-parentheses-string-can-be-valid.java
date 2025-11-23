class Solution {
    public boolean canBeValid(String s, String locked) {
        int n = s.length();

        // A valid parentheses string must have an even length.
        if (n % 2 != 0) {
            return false;
        }

        // Pass 1: Left to right
        // This pass ensures that at any point, we have enough potential opening parentheses
        // to balance the closing parentheses encountered so far.
        // `fixedBalance` tracks the balance of fixed '(' and ')' characters.
        // `flexibleCount` tracks the number of '0's (unlocked positions) which can be either '(' or ')'.
        // To satisfy the prefix condition (number of '(' >= number of ')'), we assume unlocked positions
        // are used as '(' if needed to maintain a non-negative balance.
        // The condition `fixedBalance + flexibleCount < 0` means that even if all available
        // flexible positions are used as '(', we still have an excess of ')' that cannot be balanced.
        int fixedBalance = 0;
        int flexibleCount = 0;
        for (int i = 0; i < n; i++) {
            if (locked.charAt(i) == '1') {
                if (s.charAt(i) == '(') {
                    fixedBalance++;
                } else {
                    fixedBalance--;
                }
            } else { // locked.charAt(i) == '0'
                flexibleCount++;
            }

            // If `fixedBalance + flexibleCount` becomes negative, it implies that
            // even if we treat all `flexibleCount` positions as opening parentheses,
            // the total count of opening parentheses is less than the count of closing parentheses.
            // This violates the prefix condition for a valid parentheses string.
            if (fixedBalance + flexibleCount < 0) {
                return false;
            }
        }

        // Pass 2: Right to left
        // This pass ensures that at any point (when reading from right to left),
        // we have enough potential closing parentheses to balance the opening parentheses encountered.
        // This is symmetric to the first pass.
        // `fixedBalance` now tracks the balance of fixed ')' and '(' (from the right).
        // `flexibleCount` tracks the number of '0's (unlocked positions).
        // To satisfy the suffix condition (number of ')' >= number of '(' when reading right-to-left),
        // we assume unlocked positions are used as ')' if needed to maintain a non-negative balance.
        // The condition `fixedBalance + flexibleCount < 0` means that even if all available
        // flexible positions are used as ')', we still have an excess of '(' that cannot be balanced.
        fixedBalance = 0;
        flexibleCount = 0;
        for (int i = n - 1; i >= 0; i--) {
            if (locked.charAt(i) == '1') {
                if (s.charAt(i) == ')') {
                    fixedBalance++;
                } else {
                    fixedBalance--;
                }
            } else { // locked.charAt(i) == '0'
                flexibleCount++;
            }

            // If `fixedBalance + flexibleCount` becomes negative, it implies that
            // even if we treat all `flexibleCount` positions as closing parentheses,
            // the total count of closing parentheses is less than the count of opening parentheses.
            // This violates the suffix condition for a valid parentheses string.
            if (fixedBalance + flexibleCount < 0) {
                return false;
            }
        }

        // If both passes complete without returning false, it means:
        // 1. The string length is even.
        // 2. We can maintain a non-negative balance from left-to-right.
        // 3. We can maintain a non-negative balance from right-to-left.
        // These three conditions together guarantee that the string can be made valid.
        return true;
    }
}