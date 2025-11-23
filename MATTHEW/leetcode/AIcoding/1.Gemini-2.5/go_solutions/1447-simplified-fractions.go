func simplifiedFractions(n int) []string {
	var result []string
	if n == 1 {
		return result
	}

	for q := 2; q <= n; q++ {
		for p := 1; p < q; p++ {
			if gcd(p, q) == 1 {
				result = append(result, fmt.Sprintf("%d/%d", p, q))
			}
		}
	}
	return result
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}