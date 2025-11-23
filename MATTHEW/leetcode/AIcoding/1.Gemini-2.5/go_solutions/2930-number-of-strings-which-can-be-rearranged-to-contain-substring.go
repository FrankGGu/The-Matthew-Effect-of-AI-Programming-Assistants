func numberOfStrings(n int) int {
	const MOD = 1_000_000_007

	pow := func(base, exp int) int {
		res := 1
		base %= MOD
		for exp > 0 {
			if exp%2 == 1 {
				res = (