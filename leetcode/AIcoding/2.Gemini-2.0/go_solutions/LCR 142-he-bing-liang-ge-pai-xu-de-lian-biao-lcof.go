import "sort"

func trainingPlan(nums1 []int, nums2 []int) []int {
	m := make(map[int]int)
	for _, num := range nums1 {
		m[num]++
	}
	for _, num := range nums2 {
		m[num]++
	}
	res := []int{}
	for num, count := range m {
		if count == 1 {
			res = append(res, num)
		}
	}
	sort.Ints(res)
	return res
}