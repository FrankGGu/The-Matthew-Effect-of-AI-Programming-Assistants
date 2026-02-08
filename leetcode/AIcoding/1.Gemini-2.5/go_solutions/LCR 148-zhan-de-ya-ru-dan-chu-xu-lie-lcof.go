func validateStackSequences(pushed []int, popped []int) bool {
    stack := []int{}
    j := 0

    for _, x := range pushed {
        stack = append(stack, x)
        for len(stack) > 0 && stack[len(stack)-1] == popped[j] {
            stack = stack[:len(stack)-1]
            j++
        }
    }

    return j == len(popped)
}