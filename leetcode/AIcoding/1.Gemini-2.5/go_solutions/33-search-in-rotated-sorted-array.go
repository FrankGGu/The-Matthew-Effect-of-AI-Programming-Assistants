func search(nums []int, target int) int {
	left, right := 0, len(nums)-1

	for left <= right {
		mid := left + (right-left)/2

		if nums[mid] == target {
			return mid
		}

		// Check if the left half is sorted
		if nums[left] <= nums[mid] {
			// If target is in the sorted left half
			if target >= nums[left] && target < nums[mid] {
				right = mid - 1
			} else { // Target is in the unsorted right half
				left = mid + 1
			}
		} else { // The right half is sorted
			// If target is in the sorted right half
			if target > nums[mid] && target <= nums[right] {
				left = mid + 1
			} else { // Target is in the unsorted left half
				right = mid - 1
			}
		}
	}

	return -1
}