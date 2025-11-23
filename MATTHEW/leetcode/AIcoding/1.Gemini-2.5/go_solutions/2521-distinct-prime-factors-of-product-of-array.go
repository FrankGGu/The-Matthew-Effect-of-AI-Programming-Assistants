func distinctPrimeFactors(nums []int) int {
	distinctFactors := make(map[int]bool)

	for _, num := range nums {
		// Handle factor 2
		for num%2 == 0 {
			distinctFactors[2] = true
			num /= 2
		}

		// Handle odd factors
		for i := 3; i*i <= num; i = i + 2 {
			for num%i == 0 {
				distinctFactors[i] = true
				num /= i
			}
		}

		// If num is still greater than 1, it must be a prime factor itself
		if num > 1 {
			distinctFactors[num] = true
		}
	}

	return len(distinctFactors)
}