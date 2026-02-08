func largestRectangleArea(heights []int) int {
    n := len(heights)
    if n == 0 {
        return 0
    }

    heights = append(heights, 0) // Sentinel value to process all remaining bars in the stack
    n++                          // Update n to include the sentinel

    maxArea := 0
    stack := []int{} // Stores indices of bars in increasing order of height

    for i := 0; i < n; i++ {
        // While the stack is not empty and the current bar is shorter than the bar at the top of the stack
        // This means the bar at stack.top() can potentially form a rectangle whose right boundary is 'i'
        for len(stack) > 0 && heights[stack[len(stack)-1]] >= heights[i] {
            height := heights[stack[len(stack)-1]] // Height of the bar to be popped
            stack = stack[:len(stack)-1]           // Pop the bar's index

            width := i // Default width if stack becomes empty after pop (meaning popped bar is the shortest so far, spanning from 0 to i-1)
            if len(stack) > 0 {
                // Width is current index 'i' minus index of the new top of stack minus 1
                // The new top of stack is the first bar to the left that is shorter than the popped bar
                width = i - stack[len(stack)-1] - 1
            }
            maxArea = max(maxArea, height*width)
        }
        stack = append(stack, i) // Push current bar's index onto the stack
    }

    return maxArea
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}