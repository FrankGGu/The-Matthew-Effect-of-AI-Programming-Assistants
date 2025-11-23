class Solution {
    public boolean canTransform(String start, String end) {
        if (start.length() != end.length()) {
            return false;
        }

        int n = start.length();
        int i = 0; // pointer for start string
        int j = 0; // pointer for end string

        while (i < n && j < n) {
            // Skip '_' characters in start
            while (i < n && start.charAt(i) == '_') {
                i++;
            }
            // Skip '_' characters in end
            while (j < n && end.charAt(j) == '_') {
                j++;
            }

            // If both pointers reached end simultaneously
            if (i == n && j == n) {
                return true;
            }
            // If one pointer reached end but the other didn't (implies different number of L/R chars)
            if (i == n || j == n) {
                return false;
            }

            // Characters at current non-'_' positions must be the same
            if (start.charAt(i) != end.charAt(j)) {
                return false;
            }

            // 'L' can only move left (final position j must be less than or equal to initial position i)
            if (start.charAt(i) == 'L') {
                if (i < j) { // 'L' moved right, which is impossible
                    return false;
                }
            }
            // 'R' can only move right (final position j must be greater than or equal to initial position i)
            else if (start.charAt(i) == 'R') {
                if (i > j) { // 'R' moved left, which is impossible
                    return false;
                }
            }

            // Move to the next non-'_' character
            i++;
            j++;
        }

        // After the main loop, check if any remaining non-'_' characters exist
        // This handles cases where one string might have more L/R characters than the other
        // after the main loop finishes due to one pointer reaching 'n' first.
        while (i < n && start.charAt(i) == '_') {
            i++;
        }
        while (j < n && end.charAt(j) == '_') {
            j++;
        }

        return i == n && j == n;
    }
}