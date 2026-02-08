func reverseBits(n uint32) uint32 {
	var reversed uint32 = 0
	for i := 0; i < 32; i++ {
		// Shift the reversed result to the left by 1 to make space for the next bit
		reversed = reversed << 1
		// Get the least significant bit (LSB) of n
		bit := n & 1
		// Add the LSB to the reversed result
		reversed = reversed | bit
		// Shift n to the right by 1 to process the next bit
		n = n >> 1
	}
	return reversed
}