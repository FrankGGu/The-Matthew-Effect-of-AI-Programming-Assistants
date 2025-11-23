const mod int = 1e9 + 7

func countWays(n int, k int) int {
	if n == 1 {
		return k
	}
	if n == 2 {
		return k * k % mod
	}

	same := k
	diff := k * (k - 1) % mod

	for i := 3; i <= n; i++ {
		newSame := diff
		newDiff := (same*(k-1)%mod + diff*(k-2)%mod) % mod
		same = newSame
		diff = newDiff
	}

	return (same + diff) % mod
}