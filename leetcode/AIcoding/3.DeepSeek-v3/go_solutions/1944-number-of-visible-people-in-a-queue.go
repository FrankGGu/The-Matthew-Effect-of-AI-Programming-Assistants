func canSeePersonsCount(heights []int) []int {
    n := len(heights)
    res := make([]int, n)
    stack := make([]int, 0)

    for i := n - 1; i >= 0; i-- {
        count := 0
        for len(stack) > 0 && heights[i] > stack[len(stack)-1] {
            stack = stack[:len(stack)-1]
            count++
        }
        if len(stack) > 0 {
            count++
        }
        res[i] = count
        stack = append(stack, heights[i])
    }

    return res
}