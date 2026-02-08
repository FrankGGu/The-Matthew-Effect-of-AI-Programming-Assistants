package main

func findMaximumXOR(nums []int) int {
	max := 0
	mask := 0
	for i := 31; i >= 0; i-- {
		mask = mask | (1 << i)
		prefixSet := make(map[int]bool)
		for _, num := range nums {
			prefixSet[num&mask] = true
		}
		temp := max | (1 << i)
		for prefix := range prefixSet {
			if prefixSet[temp^prefix] {
				max = temp
				break
			}
		}
	}
	return max
}