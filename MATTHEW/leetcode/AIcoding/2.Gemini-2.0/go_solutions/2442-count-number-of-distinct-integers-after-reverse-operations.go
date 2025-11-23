func countDistinctIntegers(nums []int) int {
	set := make(map[int]bool)
	for _, num := range nums {
		set[num] = true
		rev := 0
		for num > 0 {
			digit := num % 10
			rev = rev*10 + digit
			num /= 10
		}
		set[rev] = true
	}
	return len(set)
}