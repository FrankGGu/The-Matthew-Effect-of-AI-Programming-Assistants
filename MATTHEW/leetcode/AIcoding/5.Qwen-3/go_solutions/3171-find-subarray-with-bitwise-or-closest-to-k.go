package main

func closestSubarrayWithOR(nums []int, k int) int {
    n := len(nums)
    minDiff := int(1e9)
    result := 0

    for i := 0; i < n; i++ {
        currentOR := 0
        for j := i; j < n; j++ {
            currentOR |= nums[j]
            diff := abs(currentOR - k)
            if diff < minDiff {
                minDiff = diff
                result = currentOR
            }
        }
    }

    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}