package main

func largestRectangleArea(heights []int) int {
    maxArea := 0
    stack := []int{}
    heights = append(heights, 0)
    for i := 0; i < len(heights); i++ {
        for len(stack) > 0 && heights[stack[len(stack)-1]] > heights[i] {
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