func areaOfMaxDiagonal(dimensions [][]int) int {
    maxDiagonal := 0
    maxArea := 0
    for _, dim := range dimensions {
        l, w := dim[0], dim[1]
        diagonal := l*l + w*w
        if diagonal > maxDiagonal {
            maxDiagonal = diagonal
            maxArea = l * w
        } else if diagonal == maxDiagonal {
            if l * w > maxArea {
                maxArea = l * w
            }
        }
    }
    return maxArea
}