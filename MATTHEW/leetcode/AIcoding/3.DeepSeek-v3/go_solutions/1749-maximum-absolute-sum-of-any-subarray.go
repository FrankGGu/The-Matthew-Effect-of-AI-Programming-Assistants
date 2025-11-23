func maxAbsoluteSum(nums []int) int {
    maxPrefix, minPrefix, prefix := 0, 0, 0
    res := 0
    for _, num := range nums {
        prefix += num
        if prefix > maxPrefix {
            maxPrefix = prefix
        }
        if prefix < minPrefix {
            minPrefix = prefix
        }
        currentMax := abs(prefix - minPrefix)
        if currentMax > res {
            res = currentMax
        }
        currentMax = abs(prefix - maxPrefix)
        if currentMax > res {
            res = currentMax
        }
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}