import "math/bits"

func findComplement(num int) int {
	numBits := bits.Len(uint(num))
	mask := (1 << numBits) - 1
	return num ^ mask
}