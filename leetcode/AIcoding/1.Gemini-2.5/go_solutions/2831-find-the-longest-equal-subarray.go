func longestEqualSubarray(nums []int, k int) int {
	counts := make(map[int]int)
	left := 0
	maxLength := 0
	maxFreq := 0 // maxFreq stores the maximum frequency of any element