func canSeePersonsCount(heights []int) []int {
    n := len(heights)
    result := make([]int, n)
    stack := []int{}

    for i := n - 1; i >= 0; i-- {
        count := 0
        for len(stack) > 0 && heights[i] > heights[stack[len(stack)-1]] {
            stack = stack[:len(stack)-1]
            count++
        }
        if len(stack) > 0 {
            count++
        }
        result[i] = count
        stack = append(stack, i)
    }

    return result
}