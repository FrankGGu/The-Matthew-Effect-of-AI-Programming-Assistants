func canSeePersonsCount(heights []int) []int {
    n := len(heights)
    result := make([]int, n)
    stack := []int{}

    for i := 0; i < n; i++ {
        count := 0
        for len(stack) > 0 && heights[i] > stack[len(stack)-1] {
            stack = stack[:len(stack)-1]
            count++
        }
        if len(stack) > 0 {
            count++
        }
        result[i] = count
        stack = append(stack, heights[i])
    }

    return result
}