func hasAlternatingBits(n int) bool {
	lastBit := n & 1
	n >>= 1
	for n > 0 {
		currentBit := n & 1
		if currentBit == lastBit {
			return false
		}
		lastBit = currentBit
		n >>= 1
	}
	return true
}