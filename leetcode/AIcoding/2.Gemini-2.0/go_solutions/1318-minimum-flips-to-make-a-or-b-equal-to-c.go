func minFlips(a int, b int, c int) int {
	flips := 0
	for i := 0; i < 32; i++ {
		bitA := (a >> i) & 1
		bitB := (b >> i) & 1
		bitC := (c >> i) & 1

		if (bitA | bitB) != bitC {
			if bitC == 0 {
				if bitA == 1 && bitB == 1 {
					flips += 2
				} else {
					flips += 1
				}
			} else {
				flips += 1
			}
		}
	}
	return flips
}