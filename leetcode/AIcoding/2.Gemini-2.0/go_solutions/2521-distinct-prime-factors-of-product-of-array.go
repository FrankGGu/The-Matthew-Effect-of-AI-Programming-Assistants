func distinctPrimeFactors(nums []int) int {
	s := make(map[int]bool)
	for _, num := range nums {
		for i := 2; i*i <= num; i++ {
			if num%i == 0 {
				s[i] = true
				for num%i == 0 {
					num /= i
				}
			}
		}
		if num > 1 {
			s[num] = true
		}
	}
	return len(s)
}