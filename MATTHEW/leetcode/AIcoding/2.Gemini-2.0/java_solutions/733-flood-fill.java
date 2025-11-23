class Solution {
    public int[][] floodFill(int[][] image, int sr, int sc, int newColor) {
        int oldColor = image[sr][sc];
        if (oldColor == newColor) return image;
        fill(image, sr, sc, oldColor, newColor);
        return image;
    }

    private void fill(int[][] image, int r, int c, int oldColor, int newColor) {
        if (r < 0 || r >= image.length || c < 0 || c >= image[0].length || image[r][c] != oldColor) {
            return;
        }
        image[r][c] = newColor;
        fill(image, r + 1, c, oldColor, newColor);
        fill(image, r - 1, c, oldColor, newColor);
        fill(image, r, c + 1, oldColor, newColor);
        fill(image, r, c - 1, oldColor, newColor);
    }
}