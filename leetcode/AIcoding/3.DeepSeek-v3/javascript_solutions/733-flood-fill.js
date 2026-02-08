var floodFill = function(image, sr, sc, newColor) {
    const originalColor = image[sr][sc];
    if (originalColor === newColor) return image;

    const dfs = (r, c) => {
        if (r < 0 || r >= image.length || c < 0 || c >= image[0].length || image[r][c] !== originalColor) {
            return;
        }
        image[r][c] = newColor;
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    };

    dfs(sr, sc);
    return image;
};