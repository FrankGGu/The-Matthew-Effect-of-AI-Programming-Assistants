class Solution {
    public boolean isFascinating(int n) {
        // Calculate 2*n and 3*n
        int n2 = 2 * n;
        int n3 = 3 * n;

        // Concatenate n, 2*n, and 3*n into a single string
        String s = String.valueOf(n) + String.valueOf(n2) + String.valueOf(n3);

        // Check if the length of the concatenated string is 9
        if (s.length() != 9) {
            return false;
        }

        // Use a boolean array to track seen digits (1-9)
        // seen[0] is not used, as '0' is not allowed
        boolean[] seen = new boolean[10]; 

        // Iterate through the characters of the concatenated string
        for (char c : s.toCharArray()) {
            int digit = c - '0';

            // If the digit is '0' or has been seen before, it's not fascinating
            if (digit == 0 || seen[digit]) {
                return false;
            }
            // Mark the digit as seen
            seen[digit] = true;
        }

        // If all checks pass, it means the string contains unique digits from 1 to 9 exactly once.
        return true;
    }
}