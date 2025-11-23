import (
	"sort"
)

func minAbsoluteDifference(nums []int, x int) int {
	n := len(nums)
	ans := int(1e9 + 7)
	sorted := []int{}
	for i := x; i < n; i++ {
		val := nums[i]
		idx := sort.SearchInts(sorted, val)
		if idx < len(sorted) {
			ans = min(ans, abs(sorted[idx]-val))
		}
		if idx > 0 {
			ans = min(ans, abs(sorted[idx-1]-val))
		}
		sorted = insert(sorted, val)
	}
	return ans
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func insert(arr []int, val int) []int {
	idx := sort.SearchInts(arr, val)
	arr = append(arr, 0)
	copy(arr[idx+1:], arr[idx:])
	arr[idx] = val
	return arr
}