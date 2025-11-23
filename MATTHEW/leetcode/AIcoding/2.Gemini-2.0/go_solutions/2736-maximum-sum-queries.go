import (
	"sort"
)

func maximumSumQueries(nums1 []int, nums2 []int, queries [][]int) []int {
	n := len(nums1)
	q := len(queries)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}
	sort.Slice(indices, func(i, j int) bool {
		return nums1[indices[i]] > nums1[indices[j]]
	})

	queryIndices := make([]int, q)
	for i := range queryIndices {
		queryIndices[i] = i
	}
	sort.Slice(queryIndices, func(i, j int) bool {
		return queries[queryIndices[i]][0] > queries[queryIndices[j]][0]
	})

	res := make([]int, q)
	hull := [][]int{}
	j := 0
	for _, i := range queryIndices {
		x := queries[i][0]
		y := queries[i][1]
		for j < n && nums1[indices[j]] >= x {
			currX := nums2[indices[j]]
			currSum := nums1[indices[j]] + nums2[indices[j]]
			for len(hull) > 0 && currSum >= hull[len(hull)-1][1] {
				hull = hull[:len(hull)-1]
			}
			hull = append(hull, []int{currX, currSum})
			j++
		}

		l, r := 0, len(hull)-1
		ans := -1
		for l <= r {
			mid := (l + r) / 2
			if hull[mid][0] >= y {
				ans = hull[mid][1]
				r = mid - 1
			} else {
				l = mid + 1
			}
		}
		res[i] = ans
	}
	return res
}