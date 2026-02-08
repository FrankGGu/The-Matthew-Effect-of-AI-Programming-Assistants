class Solution {
    public int minFlips(String s) {
        int n = s.length();
        String s_double = s + s; 

        int flips0 = 0; // Flips needed for target pattern "01010..."
        int flips1 = 0; // Flips needed for target pattern "10101..."

        // Calculate initial flips for the first window (s_double[0...n-1])
        for (int i = 0; i < n; i++) {
            // Check against "0101..." pattern
            char expected0 = (i % 2 == 0) ? '0' : '1';
            if (s_double.charAt(i) != expected0) {
                flips0++;
            }

            // Check against "1010..." pattern
            char expected1 = (i % 2 == 0) ? '1' : '0';
            if (s_double.charAt(i) != expected1) {
                flips1++;
            }
        }

        int minFlips = Math.min(flips0, flips1);

        // Slide the window across s_double
        // 'left' is the starting index of the current window in s_double
        // The loop iterates n times, covering all n possible cyclic shifts
        for (int left = 0; left < n; left++) {
            int right = left + n; // The index of the character entering the window

            // Update flips for the character leaving the window (s_double.charAt(left))
            char char_leaving = s_double.charAt(left);

            // For flips0 (target "0101...")
            char expected0_leaving = (left % 2 == 0) ? '0' : '1';
            if (char_leaving != expected0_leaving) {
                flips0--;
            }

            // For flips1 (target "1010...")
            char expected1_leaving = (left % 2 == 0) ? '1' : '0';
            if (char_leaving != expected1_leaving) {
                flips1--;
            }

            // Update flips for the character entering the window (s_double.charAt(right))
            char char_entering = s_double.charAt(right);

            // For flips0 (target "0101...")
            char expected0_entering = (right % 2 == 0) ? '0' : '1';
            if (char_entering != expected0_entering) {
                flips0++;
            }

            // For flips1 (target "1010...")
            char expected1_entering = (right % 2 == 0) ? '1' : '0';
            if (char_entering != expected1_entering) {
                flips1++;
            }

            minFlips = Math.min(minFlips, Math.min(flips0, flips1));
        }

        return minFlips;
    }
}