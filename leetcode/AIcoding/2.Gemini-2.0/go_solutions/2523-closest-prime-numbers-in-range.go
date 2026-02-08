import (
	"math"
)

func closestPrimes(left int, right int) []int {
	primes := []int{}
	isPrime := make([]bool, right+1)
	for i := 2; i <= right; i++ {
		isPrime[i] = true
	}

	for i := 2; i <= int(math.Sqrt(float64(right))); i++ {
		if isPrime[i] {
			for j := i * i; j <= right; j += i {
				isPrime[j] = false
			}
		}
	}

	for i := left; i <= right; i++ {
		if isPrime[i] {
			primes = append(primes, i)
		}
	}

	if len(primes) < 2 {
		return []int{-1, -1}
	}

	minDiff := math.MaxInt32
	result := []int{-1, -1}
	for i := 0; i < len(primes)-1; i++ {
		diff := primes[i+1] - primes[i]
		if diff < minDiff {
			minDiff = diff
			result = []int{primes[i], primes[i+1]}
		}
	}

	return result
}