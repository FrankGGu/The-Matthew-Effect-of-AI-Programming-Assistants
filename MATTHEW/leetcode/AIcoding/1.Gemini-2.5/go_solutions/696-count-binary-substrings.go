import "math"

func countBinarySubstrings(s string) int {
	n := len(s)
	if n < 2 {
		return 0
	}

	count := 0
	prevGroupLength := 0
	currGroupLength := 1

	for i := 1; i < n; i++ {
		if s[i] == s[i-1] {
			currGroupLength++
		} else {
			count += int(math.Min(float64(prevGroupLength), float64(currGroupLength)))
			prevGroupLength = currGroupLength
			currGroupLength = 1
		}
	}
	count += int(math.Min(float64(prevGroupLength), float64(currGroupLength)))

	return count
}