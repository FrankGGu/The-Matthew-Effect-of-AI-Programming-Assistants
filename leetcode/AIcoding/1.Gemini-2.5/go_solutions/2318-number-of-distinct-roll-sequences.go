const MOD = 1e9 + 7

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func distinctSequences(n int) int