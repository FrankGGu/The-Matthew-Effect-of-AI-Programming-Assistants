package main

func maximumTripletValue(nums []int) int {
    n := len(nums)
    maxVal := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if nums[i] > nums[j] {
                for k := j + 1; k < n; k++ {
                    if nums[j] < nums[k] {
                        current := nums[i] - nums[j] - nums[k]
                        if current > maxVal {
                            maxVal = current
                        }
                    }
                }
            }
        }
    }
    return maxVal
}