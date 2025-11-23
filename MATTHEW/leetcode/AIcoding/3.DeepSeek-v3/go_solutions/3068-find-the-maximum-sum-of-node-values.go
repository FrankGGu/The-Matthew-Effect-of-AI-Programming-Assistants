func maximumValueSum(nums []int, k int, edges [][]int) int64 {
    n := len(nums)
    total := 0
    count := 0
    minDiff := 1 << 30

    for i := 0; i < n; i++ {
        xor := nums[i] ^ k
        if xor > nums[i] {
            total += xor
            count++
        } else {
            total += nums[i]
        }
        diff := abs(nums[i] - xor)
        if diff < minDiff {
            minDiff = diff
        }
    }

    if count%2 == 1 {
        total -= minDiff
    }

    return int64(total)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}