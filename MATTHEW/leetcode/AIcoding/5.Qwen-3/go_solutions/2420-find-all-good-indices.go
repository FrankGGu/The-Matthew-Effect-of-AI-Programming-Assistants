package main

func findGoodIndices(nums []int, k int) []int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    for i := 1; i < n; i++ {
        if nums[i] >= nums[i-1] {
            left[i] = left[i-1] + 1
        } else {
            left[i] = 0
        }
    }

    for i := n - 2; i >= 0; i-- {
        if nums[i] >= nums[i+1] {
            right[i] = right[i+1] + 1
        } else {
            right[i] = 0
        }
    }

    result := []int{}
    for i := 0; i < n; i++ {
        if i-1 >= 0 && i+1 < n && left[i] >= k-1 && right[i] >= k-1 {
            result = append(result, i)
        }
    }

    return result
}