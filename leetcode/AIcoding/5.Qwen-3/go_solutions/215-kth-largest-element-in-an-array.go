package main

func findKthLargest(nums []int, k int) int {
    return quickSelect(nums, 0, len(nums)-1, len(nums)-k)
}

func quickSelect(nums []int, left, right, target int) int {
    for left < right {
        pivot := partition(nums, left, right)
        if pivot == target {
            break
        } else if pivot < target {
            left = pivot + 1
        } else {
            right = pivot - 1
        }
    }
    return nums[left]
}

func partition(nums []int, left, right int) int {
    pivot := nums[right]
    i := left
    for j := left; j < right; j++ {
        if nums[j] <= pivot {
            nums[i], nums[j] = nums[j], nums[i]
            i++
        }
    }
    nums[i], nums[right] = nums[right], nums[i]
    return i
}