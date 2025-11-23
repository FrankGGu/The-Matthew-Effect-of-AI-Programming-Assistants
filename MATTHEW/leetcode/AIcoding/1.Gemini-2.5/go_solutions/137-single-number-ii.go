func singleNumber(nums []int) int {
	ones := 0
	twos := 0

	for _, num := range nums {
		twos |= (ones & num)
		ones ^= num
		common_mask := (ones & twos)
		ones &^= common_mask
		twos &^= common_mask
	}

	return ones
}