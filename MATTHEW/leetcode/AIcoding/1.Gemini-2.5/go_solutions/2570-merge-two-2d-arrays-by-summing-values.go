import "sort"

func mergeArrays(nums1 [][]int, nums2 [][]int) [][]int {
	sumMap := make(map[int]int)

	for _, pair := range nums1 {
		id := pair[0]
		val := pair[1]
		sumMap[id] += val
	}

	for _, pair := range nums2 {
		id := pair[0]
		val := pair[1]
		sumMap[id] += val
	}

	result := make([][]int, 0, len(sumMap))
	for id, val := range sumMap {
		result = append(result, []int{id, val})
	}

	sort.Slice(result, func(i, j int) bool {
		return result[i][0] < result[j][0]
	})

	return result
}