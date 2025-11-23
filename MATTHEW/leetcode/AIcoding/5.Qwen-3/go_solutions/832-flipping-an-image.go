package main

func flipAndInvertImage(image [][]int) [][]int {
    for i := range image {
        left, right := 0, len(image[i])-1
        for left < right {
            image[i][left], image[i][right] = image[i][right], image[i][left]
            left++
            right--
        }
    }
    for i := range image {
        for j := range image[i] {
            image[i][j] ^= 1
        }
    }
    return image
}