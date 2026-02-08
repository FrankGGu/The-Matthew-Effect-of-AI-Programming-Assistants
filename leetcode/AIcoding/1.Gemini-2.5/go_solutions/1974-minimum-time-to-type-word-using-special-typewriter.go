import "math"

func minTimeToType(word string) int {
	time := 0
	currentChar := byte('a')

	for i := 0; i < len(word); i++ {
		targetChar := word[i]

		diff := int(math.Abs(float64(targetChar - currentChar)))

		moves := int(math.Min(float64(diff), float64(26-diff)))

		time += moves
		time += 1 // for typing the character

		currentChar = targetChar
	}

	return time
}