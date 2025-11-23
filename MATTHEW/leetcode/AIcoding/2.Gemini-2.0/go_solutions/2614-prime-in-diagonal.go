func diagonalPrime(nums [][]int) int {
	n := len(nums)
	maxPrime := 0
	isPrime := func(num int) bool {
		if num <= 1 {
			return false
		}
		for i := 2; i*i <= num; i++ {
			if num%i == 0 {
				return false
			}
		}
		return true
	}

	for i := 0; i < n; i++ {
		if isPrime(nums[i][i]) {
			if nums[i][i] > maxPrime {
				maxPrime = nums[i][i]
			}
		}
		if isPrime(nums[i][n-1-i]) {
			if nums[i][n-1-i] > maxPrime {
				maxPrime = nums[i][n-1-i]
			}
		}
	}

	return maxPrime
}