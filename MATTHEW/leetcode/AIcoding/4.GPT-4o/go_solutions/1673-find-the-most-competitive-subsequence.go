func mostCompetitive(nums []int, k int) []int {
    n := len(nums)
    stack := []int{}
    toPop := n - k

    for _, num := range nums {
        for len(stack) > 0 && toPop > 0 && stack[len(stack)-1] > num {
            stack = stack[:len(stack)-1]
            toPop--
        }
        stack = append(stack, num)
    }

    return stack[:k]
}