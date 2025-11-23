package main

func maxOperations(nums []int) int {
    n := len(nums)
    if n < 2 {
        return 0
    }
    count := make(map[int]int)
    for i := 0; i < n-1; i++ {
        for j := i + 1; j < n; j++ {
            sum := nums[i] + nums[j]
            count[sum]++
        }
    }
    maxOp := 0
    for _, v := range count {
        if v > maxOp {
            maxOp = v
        }
    }
    return maxOp
}