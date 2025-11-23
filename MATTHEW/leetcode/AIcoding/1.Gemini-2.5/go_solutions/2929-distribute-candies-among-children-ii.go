func distributeCandies(n int, limit int) int64 {
	// Helper function to calculate combinations C(k, 2)
	// C(k, 2) = k * (k - 1) / 2
	// If k < 2, C(k, 2) is 0
	combinations