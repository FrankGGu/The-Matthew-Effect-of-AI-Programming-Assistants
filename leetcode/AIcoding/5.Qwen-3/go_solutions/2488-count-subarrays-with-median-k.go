package main

func numsBetweenK(nums []int, k int) int {
    count := 0
    for _, num := range nums {
        if num == k {
            count++
        }
    }
    return count
}

func findMedianIndex(nums []int, k int) int {
    for i, num := range nums {
        if num == k {
            return i
        }
    }
    return -1
}

func countSubarraysWithMedianK(nums []int, k int) int {
    medianIndex := findMedianIndex(nums, k)
    if medianIndex == -1 {
        return 0
    }

    n := len(nums)
    result := 0

    balance := 0
    countBalance := make(map[int]int)
    countBalance[0] = 1

    for i := 0; i < n; i++ {
        if nums[i] < k {
            balance--
        } else if nums[i] > k {
            balance++
        }

        if i < medianIndex {
            if balance == 0 {
                result++
            }
        } else {
            result += countBalance[balance]
        }

        if i >= medianIndex {
            countBalance[balance]++
        }
    }

    return result
}