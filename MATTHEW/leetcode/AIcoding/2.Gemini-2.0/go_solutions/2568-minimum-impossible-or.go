func minImpossibleOR(nums []int) int {
	seen := make(map[int]bool)
	for _, num := range nums {
		seen[num] = true
	}
	for i := 1; i <= 1<<31; i <<= 1 {
		if !seen[i] {
			return i
		}
	}
	return -1
}