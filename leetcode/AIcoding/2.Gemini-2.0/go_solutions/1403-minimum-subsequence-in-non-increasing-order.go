import "sort"

func minSubsequence(nums []int) []int {
	sort.Sort(sort.Reverse(sort.IntSlice(nums)))
	totalSum := 0
	for _, num := range nums {
		totalSum += num
	}
	currentSum := 0
	result := []int{}
	for _, num := range nums {
		currentSum += num
		result = append(result, num)
		totalSum -= num
		if currentSum > totalSum {
			break
		}
	}
	return result
}