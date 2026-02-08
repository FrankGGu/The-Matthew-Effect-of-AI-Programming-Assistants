package main

func jump(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    jumps := 0
    end := 0
    farthest := 0

    for i := 0; i < n-1; i++ {
        if i+nums[i] > farthest {
            farthest = i + nums[i]
        }

        if i == end {
            jumps++
            end = farthest
            if end >= n-1 {
                break
            }
        }
    }

    return jumps
}