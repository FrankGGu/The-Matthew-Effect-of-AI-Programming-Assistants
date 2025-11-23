class Solution {
    public int minimumDeletions(String s) {
        int n = s.length();

        // b_left: counts 'b's in the prefix s[0...i_split-1]
        // a_right: counts 'a's in the suffix s[i_split...n-1]
        int b_left = 0;
        int a_right = 0;

        // First pass: calculate the total number of 'a's in the string.
        // This represents a_right for the initial split point (i_split = 0),
        // where the entire string is considered the 'b' suffix part.
        for (char c : s.toCharArray()) {
            if (c == 'a') {
                a_right++;
            }
        }

        // Initialize min_deletions with the cost for the split point at index 0.
        // At i_split = 0, the prefix (s[0...-1]) is empty, so b_left is 0.
        // The suffix (s[0...n-1]) is the entire string, so a_right is total 'a's.
        // Deletions = (b's in empty prefix) + (a's in full string) = 0 + total 'a's.
        int min_deletions = a_right; 

        // Iterate through all possible split points from 1 to n.
        // 'i_split' represents the index where the 'a's part ends and the 'b's part begins.
        // So, s[0...i_split-1] should ideally contain only 'a's,
        // and s[i_split...n-1] should ideally contain only 'b's.
        for (int i_split = 1; i_split <= n; i_split++) {
            char currentChar = s.charAt(i_split - 1); // The character at the current boundary

            if (currentChar == 'a') {
                // If the character moving from suffix to prefix is 'a',
                // it means this 'a' is no longer in the 'b' suffix part.
                a_right--; 
            } else { // currentChar == 'b'
                // If the character moving from suffix to prefix is 'b',
                // it means this 'b' is now in the 'a' prefix part,
                // contributing to deletions if it's not removed.
                b_left++;
            }

            // Calculate the deletions needed for the current split point 'i_split'.
            // This is the sum of 'b's in the 'a' prefix part and 'a's in the 'b' suffix part.
            min_deletions = Math.min(min_deletions, b_left + a_right);
        }

        return min_deletions;
    }
}