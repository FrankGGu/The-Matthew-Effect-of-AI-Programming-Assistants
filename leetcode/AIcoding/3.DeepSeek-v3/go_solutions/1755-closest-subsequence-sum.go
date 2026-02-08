func minAbsDifference(nums []int, goal int) int {
    n := len(nums)
    half := n / 2

    left := make([]int, 0)
    for i := 0; i < (1 << half); i++ {
        sum := 0
        for j := 0; j < half; j++ {
            if (i & (1 << j)) != 0 {
                sum += nums[j]
            }
        }
        left = append(left, sum)
    }

    right := make([]int, 0)
    for i := 0; i < (1 << (n - half)); i++ {
        sum := 0
        for j := 0; j < (n - half); j++ {
            if (i & (1 << j)) != 0 {
                sum += nums[half + j]
            }
        }
        right = append(right, sum)
    }

    sort.Ints(right)
    res := math.MaxInt32

    for _, num := range left {
        target := goal - num
        idx := sort.SearchInts(right, target)
        if idx < len(right) {
            res = min(res, abs(target - right[idx]))
        }
        if idx > 0 {
            res = min(res, abs(target - right[idx-1]))
        }
    }

    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}