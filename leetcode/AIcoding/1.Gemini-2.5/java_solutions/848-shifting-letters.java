class Solution {
    public String shiftingLetters(String s, int[] shifts) {
        char[] chars = s.toCharArray();
        int n = shifts.length;
        long totalShift = 0;

        for (int i = n - 1; i >= 0; i--) {
            totalShift += shifts[i];

            // Calculate the new position for the character
            // (chars[i] - 'a') gives the 0-indexed position of the original character
            // totalShift is the accumulated shift for this character
            // % 26 ensures it wraps around 'z'
            // + 'a' converts it back to a character
            chars[i] = (char) (((chars[i] - 'a' + totalShift) % 26) + 'a');
        }

        return new String(chars);
    }
}