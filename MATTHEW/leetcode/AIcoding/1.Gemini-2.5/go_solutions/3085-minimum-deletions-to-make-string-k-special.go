import "math"

func minimumDeletions(s string, k int) int {
	freqMap := make(map[rune]int)
	for _, char := range s {
		freqMap[char]++
	}

	// Collect frequencies into a slice for easier iteration
	// and to handle cases where characters are deleted completely