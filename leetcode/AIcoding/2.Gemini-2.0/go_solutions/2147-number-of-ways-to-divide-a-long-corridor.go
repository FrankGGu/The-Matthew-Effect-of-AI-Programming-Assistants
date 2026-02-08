func numberOfWays(corridor string) int {
	seats := 0
	for _, c := range corridor {
		if c == 'S' {
			seats++
		}
	}

	if seats == 0 || seats%2 != 0 {
		return 0
	}

	const mod int = 1e9 + 7
	count := 0
	ans := 1
	plants := 0

	for i := 0; i < len(corridor); i++ {
		if corridor[i] == 'S' {
			count++
			if count > 2 {
				ans = (ans * (plants + 1)) % mod
				plants = 0
				count = 1
			}
		} else if count == 2 {
			plants++
		}
	}

	return ans
}