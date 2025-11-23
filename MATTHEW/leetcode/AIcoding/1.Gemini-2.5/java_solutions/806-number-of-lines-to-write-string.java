class Solution {
    public int[] numberOfLines(int[] widths, String s) {
        int lines = 1;
        int currentLineWidth = 0;
        int maxLineWidth = 100;

        for (char c : s.toCharArray()) {
            int charWidth = widths[c - 'a'];
            if (currentLineWidth + charWidth > maxLineWidth) {
                lines++;
                currentLineWidth = charWidth;
            } else {
                currentLineWidth += charWidth;
            }
        }

        return new int[]{lines, currentLineWidth};
    }
}