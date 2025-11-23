import (
	"strconv"
)

func summaryRanges(nums []int) []string {
	if len(nums) == 0 {
		return []string{}
	}

	result := []string{}
	i := 0
	for i < len(nums) {
		start := nums[i]
		j := i
		for j+1 < len(nums) && nums[j+1] == nums[j]+1 {
			j++
		}
		end := nums[j]

		if start == end {
			result = append(result, strconv.Itoa(start))
		} else {
			result = append(result, strconv.Itoa(start)+"->"+strconv.Itoa(end))
		}
		i = j + 1
	}

	return result
}