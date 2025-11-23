package main

func distinctAverages(nums []int) int {
    seen := make(map[float64]bool)
    n := len(nums)
    for i := 0; i < n/2; i++ {
        minVal := nums[i]
        maxVal := nums[i]
        for j := i + 1; j < n-i; j++ {
            if nums[j] < minVal {
                minVal = nums[j]
            }
            if nums[j] > maxVal {
                maxVal = nums[j]
            }
        }
        avg := float64(minVal+maxVal) / 2
        seen[avg] = true
    }
    return len(seen)
}