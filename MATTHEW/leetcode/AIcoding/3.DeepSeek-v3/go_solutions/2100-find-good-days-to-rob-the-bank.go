func goodDaysToRobBank(security []int, time int) []int {
    n := len(security)
    left := make([]int, n)
    right := make([]int, n)

    for i := 1; i < n; i++ {
        if security[i] <= security[i-1] {
            left[i] = left[i-1] + 1
        }
    }

    for i := n - 2; i >= 0; i-- {
        if security[i] <= security[i+1] {
            right[i] = right[i+1] + 1
        }
    }

    res := []int{}
    for i := 0; i < n; i++ {
        if left[i] >= time && right[i] >= time {
            res = append(res, i)
        }
    }

    return res
}