package main

func findUnsortedSubarray(nums []int) int {
    n := len(nums)
    left, right := 0, n-1

    for left < n-1 && nums[left] <= nums[left+1] {
        left++
    }

    if left == n-1 {
        return 0
    }

    for right > 0 && nums[right] >= nums[right-1] {
        right--
    }

    minSub := nums[left]
    maxSub := nums[left]

    for i := left; i <= right; i++ {
        if nums[i] < minSub {
            minSub = nums[i]
        }
        if nums[i] > maxSub {
            maxSub = nums[i]
        }
    }

    for left >= 0 && nums[left] > minSub {
        left--
    }

    for right < n && nums[right] < maxSub {
        right++
    }

    return right - left - 1
}