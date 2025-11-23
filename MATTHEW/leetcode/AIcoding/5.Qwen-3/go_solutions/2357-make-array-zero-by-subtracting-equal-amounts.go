package main

func arrayZeroAfterSubtractingEquals(nums []int) int {
    count := 0
    for {
        var min int
        found := false
        for _, num := range nums {
            if num > 0 {
                found = true
                if min == 0 || num < min {
                    min = num
                }
            }
        }
        if !found {
            break
        }
        for i := range nums {
            if nums[i] > 0 {
                nums[i] -= min
            }
        }
        count++
    }
    return count
}