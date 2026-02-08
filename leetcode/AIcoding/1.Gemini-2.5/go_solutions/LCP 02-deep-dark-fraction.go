func fraction(numerator int, denominator int) []int {
	result := []int{}
	for denominator != 0 {
		q := numerator / denominator
		result = append(result, q)

		// This is the core step of the Euclidean algorithm applied to continued fractions.
		// If a/b = q + (a % b) / b, then a/b = q + 1 / (b / (a % b)).
		// The next fraction to process is b / (a % b).
		numerator, denominator = denominator, numerator%denominator
	}
	return result
}