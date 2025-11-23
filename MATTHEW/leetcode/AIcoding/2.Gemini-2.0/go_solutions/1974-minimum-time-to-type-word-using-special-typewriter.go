import "math"

func minTimeToType(word string) int {
	res := len(word)
	curr := 'a'
	for _, char := range word {
		diff := int(math.Abs(float64(char - curr)))
		res += int(math.Min(float64(diff), float64(26-diff)))
		curr = char
	}
	return res
}