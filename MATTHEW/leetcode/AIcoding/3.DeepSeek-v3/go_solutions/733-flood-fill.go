func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    oldColor := image[sr][sc]
    if oldColor == newColor {
        return image
    }
    rows, cols := len(image), len(image[0])
    var dfs func(int, int)
    dfs = func(r, c int) {
        if r < 0 || r >= rows || c < 0 || c >= cols || image[r][c] != oldColor {
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