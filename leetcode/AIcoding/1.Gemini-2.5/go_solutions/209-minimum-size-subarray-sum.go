import "math"

func minSubArrayLen(target int, nums []int) int {
    n := len(nums)
    minLen := math.MaxInt32
    currentSum := 0
    left := 0

    for right := 0; right < n; right++ {
        currentSum += nums[right]

        for currentSum >= target {
            minLen = min(minLen, right-left+1)
            currentSum -= nums[left]
            left++
        }
    }

    if minLen == math.MaxInt32 {
        return 0
    }
    return minLen
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}