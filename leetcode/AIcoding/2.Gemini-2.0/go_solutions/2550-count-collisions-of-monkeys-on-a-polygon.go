func monkeyMove(n int) int {
	mod := 1000000007
	res := 1
	base := 2
	power := n
	for power > 0 {
		if power%2 == 1 {
			res = (res * base) % mod
		}
		base = (base * base) % mod
		power /= 2
	}
	return (res - 2 + mod) % mod
}