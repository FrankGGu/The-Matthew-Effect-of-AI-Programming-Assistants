import "sort"

func maximumPrimeDifference(nums []int) int {
	sort.Ints(nums)
	primes := make([]int, 0)
	for _, num := range nums {
		isPrime := true
		if num <= 1 {
			isPrime = false
		} else {
			for i := 2; i*i <= num; i++ {
				if num%i == 0 {
					isPrime = false
					break
				}
			}
		}
		if isPrime {
			primes = append(primes, num)
		}
	}

	if len(primes) < 2 {
		return -1
	}

	return primes[len(primes)-1] - primes[0]
}