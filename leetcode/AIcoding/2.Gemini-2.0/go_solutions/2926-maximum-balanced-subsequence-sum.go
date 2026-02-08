import (
	"sort"
)

func maxBalancedSubsequenceSum(nums []int) int64 {
	n := len(nums)
	coords := make([]int, n)
	for i := 0; i < n; i++ {
		coords[i] = nums[i] - (i + 1)
	}
	sort.Ints(coords)
	uniqueCoords := []int{}
	for i := 0; i < n; i++ {
		if i == 0 || coords[i] != coords[i-1] {
			uniqueCoords = append(uniqueCoords, coords[i])
		}
	}

	m := len(uniqueCoords)
	bit := make([]int64, m+1)

	update := func(idx int, val int64) {
		for idx <= m {
			bit[idx] = max(bit[idx], val)
			idx += idx & (-idx)
		}
	}

	query := func(idx int) int64 {
		res := int64(-1e15)
		for idx > 0 {
			res = max(res, bit[idx])
			idx -= idx & (-idx)
		}
		return res
	}

	for i := 0; i < n; i++ {
		idx := sort.SearchInts(uniqueCoords, nums[i]-(i+1)) + 1
		curr := query(idx)
		curr = max(curr, 0)
		curr += int64(nums[i])
		update(idx, curr)
	}

	return query(m)
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}