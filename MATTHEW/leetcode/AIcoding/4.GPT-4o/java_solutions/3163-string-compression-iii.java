class Solution {
    public int compress(char[] chars) {
        int n = chars.length;
        int write = 0, left = 0;

        while (left < n) {
            char currentChar = chars[left];
            int count = 0;

            while (left < n && chars[left] == currentChar) {
                left++;
                count++;
            }

            chars[write++] = currentChar;
            if (count > 1) {
                for (char digit : Integer.toString(count).toCharArray()) {
                    chars[write++] = digit;
                }
            }
        }

        return write;
    }
}