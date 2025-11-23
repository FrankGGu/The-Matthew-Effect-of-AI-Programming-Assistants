func minOperations(nums []int, k int) int {
    n := len(nums)
    freq := make(map[int]int)
    for i := 0; i < n; i++ {
        freq[nums[i]]++
    }

    minOps := n
    for num, count := range freq {
        ops := 0
        for i := 0; i < n; i++ {
            if nums[i] != num {
                ops++
            }
            if i >= k-1 {
                if nums[i-k+1] != num {
                    ops--
                }
            }
            if i >= k-1 {
                minOps = min(minOps, ops)
            }
        }
    }
    return minOps
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}