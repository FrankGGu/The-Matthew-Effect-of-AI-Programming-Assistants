class Solution {
    public String getSmallestString(String s) {
        char[] chars = s.toCharArray();
        int n = chars.length;

        int firstNonA = -1;
        for (int i = 0; i < n; i++) {
            if (chars[i] != 'a') {
                firstNonA = i;
                break;
            }
        }

        if (firstNonA == -1) {
            // All characters are 'a'. Change the last 'a' to 'z'.
            chars[n - 1] = 'z';
        } else {
            // Found the first non-'a' character.
            // Change all subsequent non-'a' characters to their previous letter.
            for (int i = firstNonA; i < n; i++) {
                if (chars[i] != 'a') {
                    chars[i] = (char) (chars[i] - 1);
                } else {
                    // Stop when an 'a' is encountered
                    break;
                }
            }
        }

        return new String(chars);
    }
}