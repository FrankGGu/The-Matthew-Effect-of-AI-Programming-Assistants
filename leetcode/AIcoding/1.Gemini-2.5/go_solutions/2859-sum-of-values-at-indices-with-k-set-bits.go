package main

func sumIndicesWithKSetBits(nums []int, k int) int {
	totalSum := 0
	for i := 0; i < len(nums); i++ {
		setBitsCount := 0
		num := i
		for num > 0 {
			if num&1 == 1 {
				setBitsCount++
			}
			num >>= 1
		}

		if setBitsCount == k {
			totalSum += nums[i]
		}
	}
	return totalSum
}