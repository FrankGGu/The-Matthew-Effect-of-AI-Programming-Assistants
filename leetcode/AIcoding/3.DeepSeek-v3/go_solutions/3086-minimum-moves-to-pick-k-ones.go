func minMoves(nums []int, k int) int {
    ones := []int{}
    for i, num := range nums {
        if num == 1 {
            ones = append(ones, i)
        }
    }
    n := len(ones)
    prefix := make([]int, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + ones[i]
    }
    res := math.MaxInt32
    radius := (k - 1) / 2
    for i := radius; i < n-radius; i++ {
        left := i - radius
        right := i + radius
        if k%2 == 1 {
            cost := (prefix[right+1] - prefix[i+1]) - (prefix[i] - prefix[left]) - radius*(radius+1)
            res = min(res, cost)
        } else {
            cost := (prefix[right+1] - prefix[i+1]) - (prefix[i] - prefix[left]) - ones[i] - radius*(radius+1) + (radius + 1)
            res = min(res, cost)
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