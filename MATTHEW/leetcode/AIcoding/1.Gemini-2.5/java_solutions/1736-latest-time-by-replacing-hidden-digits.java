class Solution {
    public String maximumTime(String time) {
        char[] chars = time.toCharArray();

        // Handle hours
        if (chars[0] == '?' && chars[1] == '?') {
            chars[0] = '2';
            chars[1] = '3';
        } else if (chars[0] == '?') {
            // Only chars[0] is '?'
            if (chars[1] >= '4') { // If second digit is 4-9, first digit must be 0 or 1. To maximize, choose 1.
                chars[0] = '1';
            } else { // If second digit is 0-3, first digit can be 0, 1, or 2. To maximize, choose 2.
                chars[0] = '2';
            }
        } else if (chars[1] == '?') {
            // Only chars[1] is '?'
            if (chars[0] == '2') { // If first digit is 2, second digit can be 0-3. To maximize, choose 3.
                chars[1] = '3';
            } else { // If first digit is 0 or 1, second digit can be 0-9. To maximize, choose 9.
                chars[1] = '9';
            }
        }

        // Handle minutes
        if (chars[3] == '?') {
            chars[3] = '5'; // Maximize the first minute digit to 5
        }

        if (chars[4] == '?') {
            chars[4] = '9'; // Maximize the second minute digit to 9
        }

        return new String(chars);
    }
}