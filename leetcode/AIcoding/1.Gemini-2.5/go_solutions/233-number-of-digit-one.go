func countDigitOne(n int) int {
	if n < 0 {
		return 0
	}

	count := 0
	powerOf10 := 1 // Represents 10^0, 10^1, 10^2, ... for current digit position

	for powerOf10