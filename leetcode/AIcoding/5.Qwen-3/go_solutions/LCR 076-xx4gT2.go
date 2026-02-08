package main

func findKthLargest(nums []int, k int) int {
    return quickSelect(nums, 0, len(nums)-1, k)
}

func quickSelect(nums []int, left, right, k int) int {
    if left == right {
        return nums[left]
    }

    pivotIndex := partition(nums, left, right)

    if pivotIndex == k-1 {
        return nums[pivotIndex]
    } else if pivotIndex < k-1 {
        return quickSelect(nums, pivotIndex+1, right, k)
    } else {
        return quickSelect(nums, left, pivotIndex-1, k)
    }
}

func partition(nums []int, left, right int) int {
    pivot := nums[right]
    i := left

    for j := left; j < right; j++ {
        if nums[j] >= pivot {
            nums[i], nums[j] = nums[j], nums[i]
            i++
        }
    }

    nums[i], nums[right] = nums[right], nums[i]
    return i
}