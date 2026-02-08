func maximumStrongPairXor(nums []int) int {
    maxXor := 0
    n := len(nums)
    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            x, y := nums[i], nums[j]
            if abs(x - y) <= min(x, y) {
                xor := x ^ y
                if xor > maxXor {
                    maxXor = xor
                }
            }
        }
    }
    return maxXor
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}