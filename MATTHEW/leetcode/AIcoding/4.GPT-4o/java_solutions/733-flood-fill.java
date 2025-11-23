class Solution {
    public int[][] floodFill(int[][] image, int sr, int sc, int newColor) {
        int originalColor = image[sr][sc];
        if (originalColor != newColor) {
            fill(image, sr, sc, originalColor, newColor);
        }
        return image;
    }

    private void fill(int[][] image, int sr, int sc, int originalColor, int newColor) {
        if (sr < 0 || sr >= image.length || sc < 0 || sc >= image[0].length || image[sr][sc] != originalColor) {
            return;
        }
        image[sr][sc] = newColor;
        fill(image, sr + 1, sc, originalColor, newColor);
        fill(image, sr - 1, sc, originalColor, newColor);
        fill(image, sr, sc + 1, originalColor, newColor);
        fill(image, sr, sc - 1, originalColor, newColor);
    }
}