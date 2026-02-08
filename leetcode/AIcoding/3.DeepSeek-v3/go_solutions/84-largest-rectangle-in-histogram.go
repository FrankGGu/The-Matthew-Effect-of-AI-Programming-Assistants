func largestRectangleArea(heights []int) int {
    stack := make([]int, 0)
    maxArea := 0
    n := len(heights)

    for i := 0; i <= n; i++ {
        var h int
        if i == n {
            h = 0
        } else {
            h = heights[i]
        }

        for len(stack) > 0 && h < heights[stack[len(stack)-1]] {
            height := heights[stack[len(stack)-1]]
            stack = stack[:len(stack)-1]
            width := i
            if len(stack) > 0 {
                width = i - stack[len(stack)-1] - 1
            }
            area := height * width
            if area > maxArea {
                maxArea = area
            }
        }
        stack = append(stack, i)
    }

    return maxArea
}