package main

func canBeIncreasing(nums []int) bool {
	n := len(nums)
	if n <= 1 {
		return true
	}

	maxVal := 1000
	isPrime := make([]bool, maxVal+1)
	for i := 2; i <= maxVal; i++ {
		isPrime[i] = true
	}
	for p := 2; p*p <= maxVal; p++ {
		if isPrime[p] {
			for i := p * p; i <= maxVal; i += p {
				isPrime[i] = false
			}
		}
	}

	primes := []int{}
	for i := 2; i <= maxVal; i++ {
		if isPrime[i] {
			primes = append(primes, i)
		}
	}

	for i := 1; i < n; i++ {
		prevVal := nums[i-1]
		currentVal := nums[i]

		foundSubtraction := false
		for j := len(primes) - 1; j >= 0; j-- {
			p := primes[j]
			if p > currentVal {
				continue
			}
			if currentVal-p > prevVal {
				nums[i] = currentVal - p
				foundSubtraction = true
				break
			}
		}

		if !foundSubtraction {
			if currentVal <= prevVal {
				return false
			}
		}
	}

	return true
}