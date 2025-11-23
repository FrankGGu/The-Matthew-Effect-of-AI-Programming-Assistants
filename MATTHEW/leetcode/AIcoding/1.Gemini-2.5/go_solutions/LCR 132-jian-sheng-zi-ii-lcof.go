package main

func integerBreak(n int) int {
	if n == 2 {
		return 1
	}
	if n == 3 {
		return 2
	}

	remainder := n % 3
	quotient := n / 3

	if remainder == 0 {
		return power(3, quotient)
	} else if remainder == 1 {
		return power(3, quotient-1) * 4
	} else { // remainder == 2
		return power(3, quotient) * 2
	}
}

func power(base, exp int) int {
	res := 1
	for exp > 0 {
		if exp%2 == 1 {
			res *= base
		}
		base *= base
		exp /= 2
	}
	return res
}