func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    if image[sr][sc] == newColor {
        return image
    }
    oldColor := image[sr][sc]
    fill(image, sr, sc, oldColor, newColor)
    return image
}

func fill(image [][]int, sr int, sc int, oldColor int, newColor int) {
    if sr < 0 || sr >= len(image) || sc < 0 || sc >= len(image[0]) || image[sr][sc] != oldColor {
        return
    }
    image[sr][sc] = newColor
    fill(image, sr+1, sc, oldColor, newColor)
    fill(image, sr-1, sc, oldColor, newColor)
    fill(image, sr, sc+1, oldColor, newColor)
    fill(image, sr, sc-1, oldColor, newColor)
}