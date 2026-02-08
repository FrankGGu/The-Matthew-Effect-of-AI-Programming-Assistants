func sumIndicesWithKSetBits(nums []int, k int) int {
	sum := 0
	for i, num := range nums {
		if countSetBits(i) == k {
			sum += num
		}
	}
	return sum
}

func countSetBits(n int) int {
	count := 0
	for n > 0 {
		n &= (n - 1)
		count++
	}
	return count
}