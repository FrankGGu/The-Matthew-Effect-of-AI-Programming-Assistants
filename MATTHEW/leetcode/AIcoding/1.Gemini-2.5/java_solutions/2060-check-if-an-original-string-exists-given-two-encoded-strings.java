class Solution {
    private String s1, s2;
    private Boolean[][][] memo;
    // Max diff can be 40 (max length) + 999 (max number from 3 digits) = 1039.
    // Min diff can be -(40 + 999) = -1039.
    // Offset to map diff to array index [0, 2*OFFSET].
    private final int OFFSET = 1039;

    public boolean isMatch(String s1, String s2) {
        this.s1 = s1;
        this.s2 = s2;
        // memo[i][j][diff + OFFSET]
        // i: 0 to s1.length() (max 40)
        // j: 0 to s2.length() (max 40)
        // diff: -1039 to 1039 (size 2079)
        memo = new Boolean[s1.length() + 1][s2.length() + 1][2 * OFFSET + 1];
        return dfs(0, 0, 0);
    }

    private boolean dfs(int i, int j, int diff) {
        // Base case: both strings exhausted
        if (i == s1.length() && j == s2.length()) {
            return diff == 0;
        }

        // Check memoization
        if (memo[i][j][diff + OFFSET] != null) {
            return memo[i][j][diff + OFFSET];
        }

        boolean res = false;

        // Case 1: s1 is ahead (diff > 0)
        // This means s1 has 'diff' more conceptual characters to skip than s2.
        // s2 needs to catch up, or s1 needs to implicitly skip.
        if (diff > 0) {
            // Option A: s1 implicitly skips one character.
            // This means one of the 'diff' characters s1 is ahead by is consumed.
            res = dfs(i, j, diff - 1);

            // Option B: s2 processes its current segment to catch up.
            if (!res && j < s2.length()) {
                char ch2 = s2.charAt(j);
                if (Character.isLetter(ch2)) {
                    // s2 consumes 1 character, reducing the conceptual gap by 1.
                    res = dfs(i, j + 1, diff - 1);
                } else { // s2.charAt(j) is a digit
                    // s2 skips 'num' characters.
                    int num = 0;
                    for (int k = j; k < s2.length() && Character.isDigit(s2.charAt(k)); k++) {
                        num = num * 10 + (s2.charAt(k) - '0');
                        // A number must be positive to represent skips.
                        if (num > 0) {
                            // s2 skips 'num' characters, reducing the conceptual gap by 'num'.
                            res = res || dfs(i, k + 1, diff - num);
                        }
                    }
                }
            }
        }
        // Case 2: s2 is ahead (diff < 0)
        // This means s2 has 'abs(diff)' more conceptual characters to skip than s1.
        // s1 needs to catch up, or s2 needs to implicitly skip.
        else if (diff < 0) {
            // Option A: s2 implicitly skips one character.
            // This means one of the 'abs(diff)' characters s2 is ahead by is consumed.
            res = dfs(i, j, diff + 1);

            // Option B: s1 processes its current segment to catch up.
            if (!res && i < s1.length()) {
                char ch1 = s1.charAt(i);
                if (Character.isLetter(ch1)) {
                    // s1 consumes 1 character, increasing the conceptual gap by 1 (towards 0).
                    res = dfs(i + 1, j, diff + 1);
                } else { // s1.charAt(i) is a digit
                    // s1 skips 'num' characters.
                    int num = 0;
                    for (int k = i; k < s1.length() && Character.isDigit(s1.charAt(k)); k++) {
                        num = num * 10 + (s1.charAt(k) - '0');
                        if (num > 0) {
                            // s1 skips 'num' characters, increasing the conceptual gap by 'num' (towards 0).
                            res = res || dfs(k + 1, j, diff + num);
                        }
                    }
                }
            }
        }
        // Case 3: Both are aligned (diff == 0)
        // Both strings are at the same conceptual position. We need to try to advance them.
        else { // diff == 0
            // Option A: s1[i] is a letter.
            if (i < s1.length() && Character.isLetter(s1.charAt(i))) {
                // Sub-option A.1: s2[j] is also a letter and matches.
                if (j < s2.length() && Character.isLetter(s2.charAt(j)) && s1.charAt(i) == s2.charAt(j)) {
                    res = dfs(i + 1, j + 1, 0); // Both consume 1 char, remain aligned.
                }
                // Sub-option A.2: s2[j] is a digit.
                if (!res && j < s2.length() && Character.isDigit(s2.charAt(j))) {
                    // s1 consumes 1 char, s2 skips 'num' chars.
                    // New diff = (current_pos + 1) - (current_pos + num) = 1 - num.
                    int num = 0;
                    for (int k = j; k < s2.length() && Character.isDigit(s2.charAt(k)); k++) {
                        num = num * 10 + (s2.charAt(k) - '0');
                        if (num > 0) {
                            res = res || dfs(i + 1, k + 1, 1 - num);
                        }
                    }
                }
                // Sub-option A.3: s2 is exhausted or s2[j] is a non-matching letter.
                // In these cases, 'res' remains false, indicating no match for this path.
            }

            // Option B: s1[i] is a digit.
            // This path is explored if s1 has digits, regardless of previous attempts.
            if (!res && i < s1.length() && Character.isDigit(s1.charAt(i))) {
                // s1 skips 'num' characters.
                // New diff = (current_pos + num) - current_pos = num.
                int num = 0;
                for (int k = i; k < s1.length() && Character.isDigit(s1.charAt(k)); k++) {
                    num = num * 10 + (s1.charAt(k) - '0');
                    if (num > 0) {
                        res = res || dfs(k + 1, j, num);
                    }
                }
            }

            // Option C: s2[j] is a digit.
            // This path is explored if s2 has digits, regardless of previous attempts.
            if (!res && j < s2.length() && Character.isDigit(s2.charAt(j))) {
                // s2 skips 'num' characters.
                // New diff = current_pos - (current_pos + num) = -num.
                int num = 0;
                for (int k = j; k < s2.length() && Character.isDigit(s2.charAt(k)); k++) {
                    num = num * 10 + (s2.charAt(k) - '0');
                    if (num > 0) {
                        res = res || dfs(i, k + 1, -num);
                    }
                }
            }
        }

        return memo[i][j][diff + OFFSET] = res;
    }
}