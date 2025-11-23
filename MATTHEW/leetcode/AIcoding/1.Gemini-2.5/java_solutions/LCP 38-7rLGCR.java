class Solution {
    public int guardTheCastle(String s) {
        int count = 0;
        int n = s.length();
        int i = 0;
        while (i < n) {
            if (s.charAt(i) == '1') { // Wall, skip
                i++;
            } else { // s.charAt(i) == '0', needs protection
                count++;
                // Try to place a guard such that it covers s[i] and extends coverage as far right as possible.
                // The optimal greedy choice is to place a guard at i+1 if possible,
                // as it covers i, i+1, and i+2.
                if (i + 1 < n && s.charAt(i + 1) == '0') {
                    // Place guard at i+1. It covers i, i+1, i+2.
                    // Advance i by 3 to start checking from i+3.
                    i += 3;
                } else {
                    // Cannot place guard at i+1 (either out of bounds or s[i+1] is a wall).
                    // Must place guard at i. It covers i-1, i, i+1.
                    // Advance i by 2 to start checking from i+2.
                    i += 2;
                }
            }
        }
        return count;
    }
}