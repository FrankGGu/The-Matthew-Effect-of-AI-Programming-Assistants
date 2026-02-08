func largestSubmatrix(matrix [][]int) int {
    m := len(matrix)
    n := len(matrix[0])
    heights := make([]int, n)
    maxArea := 0

    for i := 0; i < m; i++ {
        for j := 0; j < n; j++ {
            if matrix[i][j] == 0 {
                heights[j] = 0
            } else {
                heights[j]++
            }
        }

        tempHeights := make([]int, n)
        copy(tempHeights, heights)
        sort.Ints(tempHeights)

        for j := 0; j < n; j++ {
            area := tempHeights[j] * (n - j)
            if area > maxArea {
                maxArea = area
            }
        }
    }

    return maxArea
}

import "sort"