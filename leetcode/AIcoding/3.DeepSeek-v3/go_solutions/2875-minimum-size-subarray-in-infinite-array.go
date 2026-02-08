func minSizeSubarray(nums []int, target int) int {
    total := 0
    for _, num := range nums {
        total += num
    }
    n := len(nums)
    k := target / total
    remaining := target % total
    if remaining == 0 {
        return k * n
    }

    prefix := make([]int, 2*n+1)
    for i := 0; i < 2*n; i++ {
        prefix[i+1] = prefix[i] + nums[i%n]
    }

    res := math.MaxInt32
    left := 0
    for right := 1; right <= 2*n; right++ {
        for prefix[right] - prefix[left] > remaining {
            left++
        }
        if prefix[right] - prefix[left] == remaining {
            res = min(res, right - left)
        }
    }

    if res == math.MaxInt32 {
        return -1
    }
    return res + k * n
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}