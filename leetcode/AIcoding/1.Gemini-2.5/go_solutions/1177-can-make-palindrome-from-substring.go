import "math/bits"

func canMakePaliQueries(s string, queries [][]int) []bool {
	n := len(s)
	prefixXor := make([]int, n+1)

	// Precompute prefix XOR sums for character parities
	// prefixXor[i] stores a bitmask where the j-th