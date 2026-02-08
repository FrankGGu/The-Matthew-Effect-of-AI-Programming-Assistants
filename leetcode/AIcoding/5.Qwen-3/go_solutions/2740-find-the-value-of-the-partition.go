package main

func findValueOfPartition(nums []int) int {
    sort.Ints(nums)
    minDiff := math.MaxInt
    for i := 1; i < len(nums); i++ {
        diff := nums[i] - nums[i-1]
        if diff < minDiff {
            minDiff = diff
        }
    }
    return minDiff
}