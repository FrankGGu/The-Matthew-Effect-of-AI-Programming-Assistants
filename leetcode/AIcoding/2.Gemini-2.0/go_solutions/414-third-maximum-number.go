import "sort"

func thirdMax(nums []int) int {
	sort.Ints(nums)
	unique := []int{}
	for i := 0; i < len(nums); i++ {
		if i == 0 || nums[i] != nums[i-1] {
			unique = append(unique, nums[i])
		}
	}

	if len(unique) >= 3 {
		return unique[len(unique)-3]
	} else {
		return unique[len(unique)-1]
	}
}