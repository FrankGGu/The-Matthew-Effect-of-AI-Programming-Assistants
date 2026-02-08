import (
	"sort"
)

func minimumSum(nums []int) int {
	n := len(nums)
	left := make([]int, n)
	right := make([]int, n)

	left[0] = nums[0]
	for i := 1, minVal := nums[0]; i < n; i++ {
		if nums[i] < minVal {
			minVal = nums[i]
		}
		left[i] = minVal
	}

	right[n-1] = nums[n-1]
	for i := n - 2, minVal := nums[n-1]; i >= 0; i-- {
		if nums[i] < minVal {
			minVal = nums[i]
		}
		right[i] = minVal
	}

	ans := int(1e10)
	for i := 1; i < n-1; i++ {
		if left[i-1] < nums[i] && right[i+1] < nums[i] {
			ans = min(ans, left[i-1]+right[i+1])
		}
	}

	if ans == int(1e10) {
		return -1
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func minimumSumSort(nums []int) int {
	n := len(nums)
	ans := int(1e10)
	for i := 1; i < n-1; i++ {
		left := []int{}
		for j := 0; j < i; j++ {
			if nums[j] < nums[i] {
				left = append(left, nums[j])
			}
		}
		right := []int{}
		for j := i + 1; j < n; j++ {
			if nums[j] < nums[i] {
				right = append(right, nums[j])
			}
		}

		if len(left) > 0 && len(right) > 0 {
			sort.Ints(left)
			sort.Ints(right)
			ans = min(ans, left[0]+right[0])
		}
	}

	if ans == int(1e10) {
		return -1
	}
	return ans
}