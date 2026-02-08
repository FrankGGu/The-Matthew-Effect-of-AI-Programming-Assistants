func maximumSumOfHeights(maxHeights []int) int64 {
    n := len(maxHeights)
    left := make([]int64, n)
    stack := []int{-1}
    sum := int64(0)

    for i := 0; i < n; i++ {
        for len(stack) > 1 && maxHeights[stack[len(stack)-1]] >= maxHeights[i] {
            j := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            sum -= int64(maxHeights[j]) * int64(j - stack[len(stack)-1])
        }
        sum += int64(maxHeights[i]) * int64(i - stack[len(stack)-1])
        left[i] = sum
        stack = append(stack, i)
    }

    right := make([]int64, n)
    stack = []int{n}
    sum = int64(0)

    for i := n - 1; i >= 0; i-- {
        for len(stack) > 1 && maxHeights[stack[len(stack)-1]] >= maxHeights[i] {
            j := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            sum -= int64(maxHeights[j]) * int64(stack[len(stack)-1] - j)
        }
        sum += int64(maxHeights[i]) * int64(stack[len(stack)-1] - i)
        right[i] = sum
        stack = append(stack, i)
    }

    var res int64 = 0
    for i := 0; i < n; i++ {
        total := left[i] + right[i] - int64(maxHeights[i])
        if total > res {
            res = total
        }
    }
    return res
}