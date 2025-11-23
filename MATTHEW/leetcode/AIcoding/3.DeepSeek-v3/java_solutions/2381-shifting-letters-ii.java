class Solution {
    public String shiftingLetters(String s, int[][] shifts) {
        int n = s.length();
        int[] diff = new int[n + 1];

        for (int[] shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int direction = shift[2] == 1 ? 1 : -1;

            diff[start] += direction;
            diff[end + 1] -= direction;
        }

        StringBuilder sb = new StringBuilder();
        int currentShift = 0;
        for (int i = 0; i < n; i++) {
            currentShift += diff[i];
            char c = s.charAt(i);
            int shifted = (c - 'a' + currentShift) % 26;
            if (shifted < 0) {
                shifted += 26;
            }
            sb.append((char) ('a' + shifted));
        }

        return sb.toString();
    }
}