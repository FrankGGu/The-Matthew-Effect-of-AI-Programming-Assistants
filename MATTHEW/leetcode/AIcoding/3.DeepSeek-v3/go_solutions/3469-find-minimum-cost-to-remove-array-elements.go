func findMinimumCost(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    stack := []int{}
    cost := 0

    for _, num := range nums {
        for len(stack) > 0 && stack[len(stack)-1] > num {
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            if len(stack) > 0 {
                cost += min(top, stack[len(stack)-1])
            } else {
                cost += top
            }
        }
        stack = append(stack, num)
    }

    for len(stack) > 1 {
        top := stack[len(stack)-1]
        stack = stack[:len(stack)-1]
        cost += min(top, stack[len(stack)-1])
    }

    return cost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}