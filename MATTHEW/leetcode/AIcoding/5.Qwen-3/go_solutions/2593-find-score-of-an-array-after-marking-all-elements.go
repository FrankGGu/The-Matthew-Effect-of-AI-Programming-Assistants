package main

func sumScore(nums []int) int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    for i := 1; i < n; i++ {
        if nums[i] > nums[i-1] {
            left[i] = left[i-1] + 1
        }
    }

    for i := n - 2; i >= 0; i-- {
        if nums[i] > nums[i+1] {
            right[i] = right[i+1] + 1
        }
    }

    score := 0
    for i := 0; i < n; i++ {
        score += left[i] + right[i] + 1
    }

    return score
}