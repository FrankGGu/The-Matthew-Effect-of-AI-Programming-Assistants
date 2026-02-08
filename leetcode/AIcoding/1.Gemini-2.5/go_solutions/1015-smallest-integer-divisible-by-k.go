func smallestRepunitDivByK(k int) int {
	// If k is even or a multiple of 5, no number consisting only of '1's
	// can be divisible by k.
	// Numbers made of '1's are always odd and never end in 0 or 5.
	if k