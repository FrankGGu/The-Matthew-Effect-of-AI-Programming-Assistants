package main

import (
	"math"
)

func maxNiceDivisors(n int) int {
	const MOD = 1000000007
	if n == 1 {
		return 0
	}
	if n == 2 {
		return 1
	}
	if n == 3 {
		return 2
	}
	var exp func(base, power int) int
	exp = func(base, power int) int {
		result := 1
		for power > 0 {
			if power%2 == 1 {
				result = result * base % MOD
			}
			base = base * base % MOD
			power /= 2
		}
		return result
	}
	k := n / 3
	r := n % 3
	if r == 0 {
		return exp(3, k)
	} else if r == 1 {
		return exp(3, k-1) * 4 % MOD
	} else {
		return exp(3, k) * 2 % MOD
	}
}