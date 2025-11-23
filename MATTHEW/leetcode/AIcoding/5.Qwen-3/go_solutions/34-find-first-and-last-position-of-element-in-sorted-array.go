package main

func searchRange(nums []int, target int) []int {
    left := findLeft(nums, target)
    if left == -1 {
        return []int{-1, -1}
    }
    right := findRight(nums, target)
    return []int{left, right}
}

func findLeft(nums []int, target int) int {
    left, right := 0, len(nums)-1
    for left <= right {
        mid := left + (right-left)/2
        if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    if left < len(nums) && nums[left] == target {
        return left
    }
    return -1
}

func findRight(nums []int, target int) int {
    left, right := 0, len(nums)-1
    for left <= right {
        mid := left + (right-left)/2
        if nums[mid] > target {
            right = mid - 1
        } else {
            left = mid + 1
        }
    }
    if right >= 0 && nums[right] == target {
        return right
    }
    return -1
}