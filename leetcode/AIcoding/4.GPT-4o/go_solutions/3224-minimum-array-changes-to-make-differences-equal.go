func minChanges(nums []int, k int) int {
    n := len(nums)
    count := make([][]int, k)
    for i := 0; i < k; i++ {
        count[i] = make([]int, 102)
    }

    for i := 0; i < n; i++ {
        count[i%k][nums[i]]++
    }

    res := n
    for i := 0; i < 102; i++ {
        totalChanges := 0
        for j := 0; j < k; j++ {
            maxCount := 0
            for x := 0; x < 102; x++ {
                if x == i {
                    continue
                }
                maxCount = max(maxCount, count[j][x])
            }
            totalChanges += n/k - maxCount
        }
        res = min(res, totalChanges)
    }

    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}