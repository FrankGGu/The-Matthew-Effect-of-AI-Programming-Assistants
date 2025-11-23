class Solution {
    public String shiftingLetters(String s, int[][] shifts) {
        int n = s.length();
        long[] shift = new long[n + 1];

        for (int[] sh : shifts) {
            int start = sh[0];
            int end = sh[1];
            int direction = sh[2] == 0 ? -1 : 1;
            shift[start] += direction;
            if (end + 1 < n) {
                shift[end + 1] -= direction;
            }
        }

        long currentShift = 0;
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < n; i++) {
            currentShift += shift[i];
            char newChar = (char) ((s.charAt(i) - 'a' + (currentShift % 26) + 26) % 26 + 'a');
            result.append(newChar);
        }

        return result.toString();
    }
}