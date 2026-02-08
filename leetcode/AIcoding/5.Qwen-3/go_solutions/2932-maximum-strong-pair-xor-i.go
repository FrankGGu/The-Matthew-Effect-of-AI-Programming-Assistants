package main

func maximumStrongPairXOR(nums []int) int {
    maxVal := 0
    for i := 0; i < len(nums); i++ {
        for j := i + 1; j < len(nums); j++ {
            if abs(nums[i]-nums[j]) <= min(nums[i], nums[j]) {
                maxVal = max(maxVal, nums[i]^nums[j])
            }
        }
    }
    return maxVal
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}