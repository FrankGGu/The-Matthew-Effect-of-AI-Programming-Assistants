func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    rows := len(image)
    if rows == 0 {
        return image
    }
    cols := len(image[0])

    originalColor := image[sr][sc]

    if originalColor == newColor {
        return image
    }

    var dfs func(r, c int)
    dfs = func(r, c int) {
        if r < 0 || r >= rows || c < 0 || c >= cols || image[r][c] != originalColor {
            return
        }

        image[r][c] = newColor

        dfs(r+1, c)
        dfs(r-1, c)
        dfs(r, c+1)
        dfs(r, c-1)
    }

    dfs(sr, sc)
    return image
}