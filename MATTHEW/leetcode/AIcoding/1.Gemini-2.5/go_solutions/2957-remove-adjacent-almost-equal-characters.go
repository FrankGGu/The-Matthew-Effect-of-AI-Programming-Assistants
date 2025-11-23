import "math"

func removeAlmostEqualCharacters(s string) string {
	stack := []byte{}

	for i := 0; i < len(s); i++ {
		char := s[i]
		if len(stack) > 0 {
			lastChar := stack[len(stack)-1]
			if math.Abs(float64(char)-float64(lastChar)) <= 1 {
				stack = stack[:len(stack)-1] // Pop
			} else {
				stack = append(stack, char) // Push
			}
		} else {
			stack = append(stack, char) // Push
		}
	}

	return string(stack)
}