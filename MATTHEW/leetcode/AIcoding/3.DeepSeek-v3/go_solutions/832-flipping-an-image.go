func flipAndInvertImage(image [][]int) [][]int {
    for i := range image {
        left, right := 0, len(image[i])-1
        for left <= right {
            image[i][left], image[i][right] = image[i][right]^1, image[i][left]^1
            left++
            right--
        }
    }
    return image
}