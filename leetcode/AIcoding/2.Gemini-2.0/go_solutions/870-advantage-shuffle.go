import (
	"sort"
)

func advantageCount(nums1 []int, nums2 []int) []int {
	n := len(nums1)
	idx := make([]int, n)
	for i := 0; i < n; i++ {
		idx[i] = i
	}

	sort.Slice(idx, func(i, j int) bool {
		return nums2[idx[i]] < nums2[idx[j]]
	})

	sort.Ints(nums1)

	res := make([]int, n)
	left, right := 0, n-1
	for i := 0; i < n; i++ {
		if nums1[i] > nums2[idx[left]] {
			res[idx[left]] = nums1[i]
			left++
		} else {
			res[idx[right]] = nums1[i]
			right--
		}
	}

	return res
}