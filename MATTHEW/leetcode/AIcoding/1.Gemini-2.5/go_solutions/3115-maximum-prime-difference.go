package main

var isPrimeArr [101]bool

func init() {
	for i := 0; i <= 100; i++ {
		isPrimeArr[i] = true
	}
	isPrimeArr[0] = false
	isPrimeArr[1] = false
	for p := 2; p*p <= 100; p++ {
		if isPrimeArr[p] {
			for i := p * p; i <= 100; i += p {
				isPrimeArr[i] = false
			}
		}
	}
}

func maximumPrimeDifference(nums []int) int {
	firstPrimeIdx := -1
	lastPrimeIdx := -1

	for i, num := range nums {
		if isPrimeArr[num] {
			if firstPrimeIdx == -1 {
				firstPrimeIdx = i
			}
			lastPrimeIdx = i
		}
	}

	if firstPrimeIdx == -1 {
		return 0
	}

	return lastPrimeIdx - firstPrimeIdx
}