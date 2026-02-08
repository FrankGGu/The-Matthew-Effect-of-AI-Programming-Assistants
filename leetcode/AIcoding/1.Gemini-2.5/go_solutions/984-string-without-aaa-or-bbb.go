import "strings"

func strWithout3a3b(a int, b int) string {
	var sb strings.Builder

	for a > 0 || b > 0 {
		// Determine which character to append greedily
		// We prioritize the character with a higher count,
		// but must also check if appending it