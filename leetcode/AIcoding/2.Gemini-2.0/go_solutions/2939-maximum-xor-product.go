func maximumXorProduct(a int64, b int64, n int) int {
	mod := int64(1e9 + 7)
	if a > b {
		a, b = b, a
	}

	if n == 0 {
		return int((a % mod) * (b % mod) % mod)
	}

	if (a>>(n-1)) == (b>>(n-1)) && (a>>(n-1))&1 == 1 {
		return int(maximumXorProduct(a^(1<<(n-1)), b^(1<<(n-1)), n-1))
	}

	if (a>>(n-1)) == (b>>(n-1)) && (a>>(n-1))&1 == 0 {
		a1 := a | (1<<(n-1))
		b1 := b
		p1 := (a1 % mod) * (b1 % mod) % mod

		a2 := a
		b2 := b | (1<<(n-1))
		p2 := (a2 % mod) * (b2 % mod) % mod

		if p1 > p2 {
			return int(p1)
		}
		return int(p2)
	}

	a1 := a | (1<<(n-1))
	b1 := b ^ (1<<(n-1))
	p1 := (a1 % mod) * (b1 % mod) % mod

	a2 := a ^ (1<<(n-1))
	b2 := b | (1<<(n-1))
	p2 := (a2 % mod) * (b2 % mod) % mod

	if p1 > p2 {
		return int(p1)
	}
	return int(p2)
}