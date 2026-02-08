import "math"

func findPrimePairs(n int) [][]int {
	// Step 1: Sieve of Eratosthenes to find all primes up to n
	is_prime := make([]bool, n+1)
	for i := 0; i <= n; i++ {
		is_prime[i] = true
	}
	if n >= 0 {
		is_prime[0] = false
	}
	if n >= 1 {
		is_prime[1] = false
	}

	// Sieve up to sqrt(n)
	for p := 2; p*p <= n; p++ {
		if is_prime[p] {
			// Mark multiples of p as not prime
			for i := p * p; i <= n; i += p {
				is_prime[i] = false
			}
		}
	}

	// Step 2: Iterate and check for prime pairs
	var result [][]int
	// Iterate x from 2 up to n/2
	// This ensures x <= y and avoids duplicate pairs (e.g., [3,7] and [7,3])
	for x := 2; x <= n/2; x++ {
		if is_prime[x] {
			y := n - x
			if is_prime[y] {
				result = append(result, []int{x, y})
			}
		}
	}

	return result
}