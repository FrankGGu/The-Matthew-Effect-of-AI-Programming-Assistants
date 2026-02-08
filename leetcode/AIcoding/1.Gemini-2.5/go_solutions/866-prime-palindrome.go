package main

func primePalindrome(N int) int {
	if N <= 2 {
		return 2
	}
	if N <= 3 {
		return 3
	}
	if N <= 5 {
		return 5
	}
	if N <= 7 {
		return 7
	}
	if N <= 11 {
		return 11
	}

	// The problem guarantees the answer is less than 2 * 10^8.
	// All even-length palindromes (except 11) are divisible by 11.
	// For example, 123321 is divisible by 11 (123321 = 11 * 11211).
	// So we only need to check odd-length palindromes.
	// Odd-length palindromes are formed by a 'first half' number and its reverse (excluding the middle digit of the first half).
	// For example, if 'half' is 123, the palindrome is 12321.
	// The maximum possible palindrome to check is 199999991 (9 digits), which is generated from 'half' = 19999.
	// The next 'half' would be 20000, which generates 200000002, exceeding 2 * 10^8.
	for half := 1; half < 20000; half++ {
		p := buildPalindrome(half)
		if p >= N && isPrime(p) {
			return p
		}
	}

	return -1 // Should not be reached based on problem constraints
}

func buildPalindrome(half int) int {
	p := half
	temp := half / 10 // For odd length, the middle digit is already in 'p', so we start reversing from the digit before the middle.
	for temp > 0 {
		p = p*10 + temp%10
		temp /= 10
	}
	return p
}

func isPrime(n int) bool {
	if n < 2 {
		return false
	}
	if n == 2 || n == 3 {
		return true
	}
	if n%2 == 0 || n%3 == 0 {
		return false
	}
	// All primes greater than 3 can be written in the form 6k ± 1.
	// So we only need to check divisibility by numbers of the form 6k ± 1.
	for i := 5; i*i <= n; i += 6 {
		if n%i == 0 || n%(i+2) == 0 {
			return false
		}
	}
	return true
}