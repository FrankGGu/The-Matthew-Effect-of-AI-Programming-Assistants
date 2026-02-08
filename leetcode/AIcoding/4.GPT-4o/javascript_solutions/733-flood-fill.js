var floodFill = function(image, sr, sc, newColor) {
    const originalColor = image[sr][sc];
    if (originalColor === newColor) return image;

    const fill = (r, c) => {
        if (r < 0 || r >= image.length || c < 0 || c >= image[0].length || image[r][c] !== originalColor) return;
        image[r][c] = newColor;
        fill(r + 1, c);
        fill(r - 1, c);
        fill(r, c + 1);
        fill(r, c - 1);
    }

    fill(sr, sc);
    return image;
};