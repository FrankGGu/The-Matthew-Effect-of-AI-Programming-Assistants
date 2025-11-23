package main

func largestNumber(nums []int) string {
	if len(nums) == 0 {
		return ""
	}
	if len(nums) == 1 {
		return strconv.Itoa(nums[0])
	}

	strs := make([]string, len(nums))
	for i := range nums {
		strs[i] = strconv.Itoa(nums[i])
	}

	sort.Slice(strs, func(i, j int) bool {
		return strs[i]+strs[j] > strs[j]+strs[i]
	})

	if strs[0] == "0" {
		return "0"
	}

	result := ""
	for _, s := range strs {
		result += s
	}
	return result
}