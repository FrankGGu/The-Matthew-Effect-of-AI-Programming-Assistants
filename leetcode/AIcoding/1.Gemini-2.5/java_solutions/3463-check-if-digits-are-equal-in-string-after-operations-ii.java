class Solution {
    public boolean areDigitsEqual(String s, int k) {
        // Step 1: Convert the initial string 's' (lowercase English letters)
        // into a digit string by replacing each letter with its position in the alphabet.
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            sb.append(c - 'a' + 1);
        }
        String currentS = sb.toString();

        // Step 2: Perform 'k' operations.
        // In each operation, replace the string with the sum of its digits,
        // then convert this sum back to a string.
        for (int op = 0; op < k; op++) {
            long sum = 0;
            for (char c : currentS.toCharArray()) {
                sum += (c - '0'); // Convert char digit to int and add to sum
            }
            currentS = String.valueOf(sum); // Update currentS with the string representation of the sum
        }

        // Step 3: After 'k' operations, check if all digits in the resulting string 'currentS' are equal.
        if (currentS.length() <= 1) {
            // If the string has 0 or 1 digit, all digits are vacuously equal.
            return true;
        }

        char firstDigit = currentS.charAt(0);
        for (int i = 1; i < currentS.length(); i++) {
            if (currentS.charAt(i) != firstDigit) {
                // If any digit is different from the first digit, return false.
                return false;
            }
        }

        // If the loop completes, all digits are equal.
        return true;
    }
}