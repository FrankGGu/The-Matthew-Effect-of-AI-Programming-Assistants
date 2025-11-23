func mctFromLeafValues(arr []int) int {
    n := len(arr)
    stack := []int{int(^uint(0) >> 1)} // max int
    ans := 0

    for _, v := range arr {
        for len(stack) > 1 && stack[len(stack)-1] <= v {
            mid := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            ans += mid * min(stack[len(stack)-1], v)
        }
        stack = append(stack, v)
    }

    for len(stack) > 1 {
        ans += stack[len(stack)-1] * stack[len(stack)-2]
        stack = stack[:len(stack)-1]
    }

    return ans
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}