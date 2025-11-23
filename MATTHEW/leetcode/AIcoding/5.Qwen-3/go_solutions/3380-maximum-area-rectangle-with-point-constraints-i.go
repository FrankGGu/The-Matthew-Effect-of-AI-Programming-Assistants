package main

func maxAreaRectangle(heights []int) int {
    if len(heights) < 2 {
        return 0
    }

    maxArea := 0
    stack := []int{}
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

    for len(stack) > 0 {
        height := heights[stack[len(stack)-1]]
        stack = stack[:len(stack)-1]
        width := len(heights)
        if len(stack) > 0 {
            width = len(heights) - stack[len(stack)-1] - 1
        }
        maxArea = max(maxArea, height*width)
    }

    return maxArea
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}