func maximalRectangle(matrix [][]byte) int {
    if len(matrix) == 0 || len(matrix[0]) == 0 {
        return 0
    }

    n := len(matrix)
    m := len(matrix[0])
    heights := make([]int, m)
    maxArea := 0

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if matrix[i][j] == '1' {
                heights[j]++
            } else {
                heights[j] = 0
            }
        }
        maxArea = max(maxArea, largestRectangleArea(heights))
    }

    return maxArea
}

func largestRectangleArea(heights []int) int {
    heights = append(heights, 0)
    stack := []int{}
    maxArea := 0

    for i, h := range heights {
        for len(stack) > 0 && heights[stack[len(stack)-1]] > h {
            height := heights[stack[len(stack)-1]]
            stack = stack[:len(stack)-1]
            width := i
            if len(stack) > 0 {
                width = i - stack[len(stack)-1] - 1
            }
            maxArea = max(maxArea, height*width)
        }
        stack = append(stack, i)
    }

    return maxArea
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}