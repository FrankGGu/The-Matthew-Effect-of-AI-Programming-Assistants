package main

func numberOfSubarrays(nums []int, pattern []int) int {
    n := len(nums)
    m := len(pattern)
    count := 0
    for i := 0; i <= n - m; i++ {
        match := true
        for j := 0; j < m; j++ {
            if nums[i+j] != pattern[j] {
                match = false
                break
            }
        }
        if match {
            count++
        }
    }
    return count
}