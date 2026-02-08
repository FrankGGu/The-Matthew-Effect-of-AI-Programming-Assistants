import "fmt"

func colorTheGrid(m int, n int) int {
	mod := 1_000_000_007

	// Step 1: Generate all valid patterns for a single column of length m.
	// A pattern is a sequence of m colors (0, 1, or