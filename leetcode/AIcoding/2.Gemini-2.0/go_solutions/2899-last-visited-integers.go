func lastVisitedIntegers(words []string) []int {
	nums := []int{}
	res := []int{}
	prev := 0
	for _, word := range words {
		if word == "prev" {
			prev++
			if len(nums)-prev < 0 {
				res = append(res, -1)
			} else {
				res = append(res, nums[len(nums)-prev])
			}
		} else {
			num, _ := strconv.Atoi(word)
			nums = append(nums, num)
			prev = 0
		}
	}
	return res
}