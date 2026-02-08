public class Solution {

import java.util.*;

public class Solution {
    public int[][] floodFill(int[][] image, int sr, int sc, int newColor) {
        if (image[sr][sc] == newColor) {
            return image;
        }
        dfs(image, sr, sc, image[sr][sc], newColor);
        return image;
    }

    private void dfs(int[][] image, int r, int c, int color, int newColor) {
        if (r < 0 || r >= image.length || c < 0 || c >= image[0].length || image[r][c] != color) {
            return;
        }
        image[r][c] = newColor;
        dfs(image, r + 1, c, color, newColor);
        dfs(image, r - 1, c, color, newColor);
        dfs(image, r, c + 1, color, newColor);
        dfs(image, r, c - 1, color, newColor);
    }
}
}