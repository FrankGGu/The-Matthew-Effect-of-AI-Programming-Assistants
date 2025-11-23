package main

func maximumTop(nums []int, k int) int {
    n := len(nums)
    if k == 0 {
        return nums[0]
    }
    if n == 1 {
        if k%2 == 0 {
            return nums[0]
        } else {
            return -1
        }
    }
    if k > n {
        return nums[n-1]
    }
    if k == n {
        return nums[n-1]
    }
    if k < n {
        maxVal := nums[0]
        for i := 1; i <= k; i++ {
            if nums[i] > maxVal {
                maxVal = nums[i]
            }
        }
        return maxVal
    }
    return -1
}