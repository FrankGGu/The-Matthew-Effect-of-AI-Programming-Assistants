import "math"

func minWindow(s string, t string) string {
	if len(t) == 0 {
		return ""
	}

	// mapT stores the frequency of characters in t
	mapT := make(map[byte]int)
	for i := 0; i < len(t); i