func singleNumber(nums []int) int {
	var ans int
	for i := 0; i < 32; i++ {
		sum := 0
		for _, num := range nums {
			if (num >> i) & 1 == 1 {
				sum++
			}
		}
		if sum%3 != 0 {
			ans |= (1 << i)
		}
	}
	return ans
}