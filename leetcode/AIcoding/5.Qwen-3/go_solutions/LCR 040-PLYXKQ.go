package main

func maximalRectangle(matrix [][]byte) int {
    if len(matrix) == 0 {
        return 0
    }
    heights := make([]int, len(matrix[0]))
    maxArea := 0
    for i := 0; i < len(matrix); i++ {
        for j := 0; j < len(matrix[0]); j++ {
            if matrix[i][j] == '1' {
                heights[j] += 1
            } else {
                heights[j] = 0
            }
        }
        maxArea = max(maxArea, largestRectangleArea(heights))
    }
    return maxArea
}

func largestRectangleArea(heights []int) int {
    maxArea := 0
    stack := []int{}
    heights = append(heights, 0)
    for i := 0; i < len(heights); i++ {
        for len(stack) > 0 && heights[i] < heights[stack[len(stack)-1]] {
            h := heights[stack[len(stack)-1]]
            stack = stack[:len(stack)-1]
            w := i
            if len(stack) > 0 {
                w = i - stack[len(stack)-1] - 1
            }
            maxArea = max(maxArea, h*w)
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