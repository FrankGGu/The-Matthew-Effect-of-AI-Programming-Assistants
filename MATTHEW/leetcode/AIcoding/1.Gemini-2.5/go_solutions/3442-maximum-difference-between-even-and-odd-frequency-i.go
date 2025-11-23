func maxDifferenceEvenOddFrequency(nums []int) int {
	evenFreq := make(map[int]int)
	oddFreq := make(map[int]int)

	for _, num := range nums {
		if num%2 == 0 {