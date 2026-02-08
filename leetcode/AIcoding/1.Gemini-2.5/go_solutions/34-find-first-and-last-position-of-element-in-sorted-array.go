package main

func searchRange(nums []int, target int) []int {
	first := findFirst(nums, target)
	if first == -1 {
		return []int{-1, -1}
	}
	last := findLast(nums, target)
	return []int{first, last}
}

func findFirst(nums []int, target int) int {
	low := 0
	high := len(nums) - 1
	first := -1

	for low <= high {
		mid := low + (high-low)/2
		if nums[mid] == target {
			first = mid
			high = mid - 1
		} else if nums[mid] < target {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return first
}

func findLast(nums []int, target int) int {
	low := 0
	high := len(nums) - 1
	last := -1

	for low <= high {
		mid := low + (high-low)/2
		if nums[mid] == target {
			last = mid
			low = mid + 1
		} else if nums[mid] < target {
			low = mid + 1
		} else {
			high = mid - 1
		}
	}
	return last
}