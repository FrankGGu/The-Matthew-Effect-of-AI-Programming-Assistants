package main

func minimumDifference(nums []int, k int) int {
    if k == 0 || len(nums) == 0 {
        return 0
    }
    sort.Ints(nums)
    minDiff := math.MaxInt32
    for i := 0; i <= len(nums)-k; i++ {
        diff := nums[i+k-1] - nums[i]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}