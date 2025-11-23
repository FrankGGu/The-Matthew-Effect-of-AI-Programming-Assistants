func totalSteps(nums []int) int {
    stack := [][2]int{}
    res := 0
    for _, num := range nums {
        maxT := 0
        for len(stack) > 0 && stack[len(stack)-1][0] <= num {
            maxT = max(maxT, stack[len(stack)-1][1])
            stack = stack[:len(stack)-1]
        }
        if len(stack) > 0 {
            maxT++
        } else {
            maxT = 0
        }
        res = max(res, maxT)
        stack = append(stack, [2]int{num, maxT})
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}