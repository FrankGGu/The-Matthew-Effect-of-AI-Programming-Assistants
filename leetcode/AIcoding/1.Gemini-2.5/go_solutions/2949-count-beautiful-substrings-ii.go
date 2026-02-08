func beautifulSubstrings(s string, k int) int64 {
	n := len(s)
	ans := int64(0)

	// Calculate L, the smallest integer such that L*L is divisible by k.
	// This means v must be a multiple of L