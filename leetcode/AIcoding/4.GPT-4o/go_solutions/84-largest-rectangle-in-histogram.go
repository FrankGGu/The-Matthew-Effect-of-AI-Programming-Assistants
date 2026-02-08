func largestRectangleArea(heights []int) int {
    stack := []int{}
    maxArea := 0
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