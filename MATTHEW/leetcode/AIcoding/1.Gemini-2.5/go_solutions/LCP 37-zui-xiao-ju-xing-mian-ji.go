package main

func largestRectangleArea(heights []int) int {
    n := len(heights)
    if n == 0 {
        return 0
    }

    maxArea := 0
    stack := []int{} // Stores indices

    for i := 0; i <= n; i++ {
        currentHeight := 0
        if i < n {
            currentHeight = heights[i]
        }

        for len(stack) > 0 && (i == n || heights[stack[len(stack)-1]] >= currentHeight) {
            h := heights[stack[len(stack)-1]]
            stack = stack[:len(stack)-1] // Pop

            width := i
            if len(stack) > 0 {
                width = i - stack[len(stack)-1] - 1
            }

            if h * width > maxArea {
                maxArea = h * width
            }
        }
        stack = append(stack, i) // Push
    }

    return maxArea
}