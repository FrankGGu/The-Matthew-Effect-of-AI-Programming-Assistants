func handleQuery(nums1 []int, nums2 []int, queries [][]int) []int64 {
	n := len(nums1)
	sum := int64(0)
	for _, num := range nums2 {
		sum += int64(num)
	}
	result := []int64{}
	for _, query := range queries {
		if query[0] == 0 {
			l, r := query[1], query[2]
			for i := l; i <= r; i++ {
				nums1[i] = 1 - nums1[i]
			}
		} else if query[0] == 1 {
			p := query[1]
			for i := 0; i < n; i++ {
				if nums1[i] == 1 {
					sum += int64(nums1[i] * p)
				}
			}

		} else {
			count := 0
			for _, num := range nums1 {
				if num == 1 {
					count++
				}
			}
			result = append(result, sum+int64(count)*int64(query[1]))
		}
	}
	return result
}