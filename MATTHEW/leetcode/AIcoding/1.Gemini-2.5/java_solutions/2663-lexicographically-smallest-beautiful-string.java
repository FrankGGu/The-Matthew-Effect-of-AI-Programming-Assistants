class Solution {
    public String smallestBeautifulString(String s, int k) {
        char[] arr = s.toCharArray();
        int n = arr.length;

        // Iterate from the rightmost character to the left
        for (int i = n - 1; i >= 0; i--) {
            // Try to increment arr[i]
            // c_val represents the 0-indexed value of the character ('a' -> 0, 'b' -> 1, etc.)
            for (int c_val = (arr[i] - 'a' + 1); c_val < k; c_val++) {
                char nextChar = (char)('a' + c_val);

                // Check if nextChar is valid at position i
                // A character is valid if it's different from the previous two characters
                boolean isValid = true;
                if (i > 0 && nextChar == arr[i-1]) {
                    isValid = false;
                }
                if (i > 1 && nextChar == arr[i-2]) {
                    isValid = false;
                }

                if (isValid) {
                    arr[i] = nextChar;
                    // Fill the rest of the string from i+1 to n-1 with the smallest possible characters
                    for (int j = i + 1; j < n; j++) {
                        char prev1 = arr[j-1];
                        // If j-2 is out of bounds, treat prev2 as a non-existent character (e.g., 0)
                        char prev2 = (j > 1) ? arr[j-2] : 0; 

                        char fillChar = 'a';
                        // Find the smallest character that is not prev1 and not prev2
                        while (fillChar < 'a' + k && (fillChar == prev1 || fillChar == prev2)) {
                            fillChar++;
                        }
                        // Based on problem constraints (s is beautiful, and if n > 2 then k >= 3),
                        // a valid fillChar should always be found here.
                        // Thus, fillChar will always be less than 'a' + k.
                        arr[j] = fillChar;
                    }
                    return new String(arr);
                }
            }
        }

        // If no such string can be found after trying all possibilities
        return "";
    }
}