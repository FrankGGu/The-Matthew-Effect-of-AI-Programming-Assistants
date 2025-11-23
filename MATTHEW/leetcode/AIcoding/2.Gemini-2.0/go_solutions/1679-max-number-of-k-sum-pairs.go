func maxOperations(nums []int, k int) int {
	count := 0
	freq := make(map[int]int)
	for _, num := range nums {
		complement := k - num
		if freq[complement] > 0 {
			count++
			freq[complement]--
		} else {
			freq[num]++
		}
	}
	return count
}