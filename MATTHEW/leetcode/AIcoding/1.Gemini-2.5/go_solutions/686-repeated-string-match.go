import "strings"

func repeatedStringMatch(a string, b string) int {
	count := 0
	s := new(strings.Builder)

	// Keep appending 'a' until the length of 's' is at least as long as 'b'.
	// This covers the minimum number of repetitions needed if 'b' is a