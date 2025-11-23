import "sort"

func countFairPairs(nums []int, lower int, upper int) int64 {
	sort.Ints(nums)
	n := len(nums)
	var count int64
	for i := 0; i < n; i++ {
		l := lowerBound(nums, lower-nums[i])
		r := upperBound(nums, upper-nums[i])
		if l <= r && l < n && r < n {
			if l <= i {
				l = i + 1
			}
			if l <= r {
				count += int64(r - l + 1)
			}
		}
	}
	return count
}

func lowerBound(nums []int, target int) int {
	left, right := 0, len(nums) - 1
	ans := len(nums)
	for left <= right {
		mid := left + (right - left) / 2
		if nums[mid] >= target {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}
	return ans
}

func upperBound(nums []int, target int) int {
	left, right := 0, len(nums) - 1
	ans := -1
	for left <= right {
		mid := left + (right - left) / 2
		if nums[mid] <= target {
			ans = mid
			left = mid + 1
		} else {
			right = mid - 1
		}
	}
	return ans
}