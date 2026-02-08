func summaryRanges(nums []int) []string {
	result := []string{}
	if len(nums) == 0 {
		return result
	}

	start := nums[0]
	end := nums[0]

	for i := 1; i < len(nums); i++ {
		if nums[i] == end+1 {
			end = nums[i]
		} else {
			if start == end {
				result = append(result, strconv.Itoa(start))
			} else {
				result = append(result, strconv.Itoa(start)+"->"+strconv.Itoa(end))
			}
			start = nums[i]
			end = nums[i]
		}
	}

	if start == end {
		result = append(result, strconv.Itoa(start))
	} else {
		result = append(result, strconv.Itoa(start)+"->"+strconv.Itoa(end))
	}

	return result
}