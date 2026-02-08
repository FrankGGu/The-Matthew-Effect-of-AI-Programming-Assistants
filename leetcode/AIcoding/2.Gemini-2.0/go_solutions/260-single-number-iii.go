func singleNumber(nums []int) []int {
	xor := 0
	for _, num := range nums {
		xor ^= num
	}

	rightmostSetBit := xor & -xor

	num1 := 0
	num2 := 0

	for _, num := range nums {
		if num&rightmostSetBit != 0 {
			num1 ^= num
		} else {
			num2 ^= num
		}
	}

	return []int{num1, num2}
}