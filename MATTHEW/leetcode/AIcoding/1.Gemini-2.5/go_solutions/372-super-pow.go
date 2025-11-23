func myPow(base int, exp int) int {
	res := 1
	const MOD = 1337
	base %= MOD
	for exp > 0 {
		if exp%2 == 1 {
			res = (res * base) % MOD
		}
		base = (base * base) % MOD
		exp /= 2
	}
	return res
}

func superPow(a int, b []int) int {
	if len(b) == 0 {
		return 1
	}

	lastDigit := b[len(b)-1]
	b_prime := b[:len(b)-1]

	part1 := myPow(superPow(a, b_prime), 10)
	part2 := myPow(a, lastDigit)

	return (part1 * part2) % 1337
}