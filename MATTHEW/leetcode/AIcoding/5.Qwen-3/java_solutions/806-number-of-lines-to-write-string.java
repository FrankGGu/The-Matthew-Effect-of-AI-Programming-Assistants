public class Solution {
    public int[] numberOfLines(int[] widths, String s) {
        int lines = 1;
        int width = 0;
        for (char c : s.toCharArray()) {
            int charWidth = widths[c - 'a'];
            if (width + charWidth > 100) {
                lines++;
                width = charWidth;
            } else {
                width += charWidth;
            }
        }
        return new int[]{lines, width};
    }
}