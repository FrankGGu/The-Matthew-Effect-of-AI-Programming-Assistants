func countTriples(n int) int {
	count := 0
	for a := 1; a <= n; a++ {
		for b := 1; b <= n; b++ {
			aSq := a * a
			bSq := b * b
			cSq := aSq + bSq

			cFloat := math.Sqrt(float64(cSq))
			cInt :=