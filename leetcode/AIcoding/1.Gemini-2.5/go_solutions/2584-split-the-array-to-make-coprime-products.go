package main

const MAX_VAL = 1000000

var spf [MAX_VAL + 1]int

func sieve() {
	for i := 0; i <= MAX_VAL; i++ {
		spf[i] = i
	}
	for i := 2; i*i <= MAX_VAL; i++ {
		if spf[i] == i {
			for j := i * i; j <= MAX_VAL; j += i {
				if spf[j] == j {
					spf[j] = i
				}
			}
		}
	}
}

func getDistinctPrimeFactors(n int) []int {
	factors := make([]int, 0)
	if n <= 1 {
		return factors
	}
	current := n
	for current > 1 {
		p := spf[current]
		factors = append(factors, p)
		for current%p == 0 {
			current /= p
		}
	}
	return factors
}

func init() {
	sieve()
}

func splitArray(nums []int) int {
	n := len(nums)
	if n == 0 {
		return -1
	}

	leftFreq := make(map[int]int)
	rightFreq := make(map[int]int)

	for j := 1; j < n; j++ {
		factors := getDistinctPrimeFactors(nums[j])
		for _, p := range factors {
			rightFreq[p]++
		}
	}

	factors0 := getDistinctPrimeFactors(nums[0])
	for _, p := range factors0 {
		leftFreq[p]++
	}

	commonPrimeFactorCount := 0
	for p := range leftFreq {
		if rightFreq[p] > 0 {
			commonPrimeFactorCount++
		}
	}

	ans := -1

	for i := 0; i < n-1; i++ {
		if commonPrimeFactorCount == 0 {
			ans = i
		}

		numToMove := nums[i+1]
		factorsToMove := getDistinctPrimeFactors(numToMove)

		for _, p := range factorsToMove {
			rightFreq[p]--
			if rightFreq[p] == 0 {
				if leftFreq[p] > 0 {
					commonPrimeFactorCount--
				}
			}
		}

		for _, p := range factorsToMove {
			if leftFreq[p] == 0 {
				if rightFreq[p] > 0 {
					commonPrimeFactorCount++
				}
			}
			leftFreq[p]++
		}
	}

	return ans
}