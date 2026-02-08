import (
	"strings"
	"unicode"
)

func clearDigits(s string) string {
	stack := []rune{}

	for _, r := range s {
		if unicode.IsDigit(r) {
			// If the current character is a digit, we need to remove the leftmost
			// non-digit character to its left. In a stack-based approach, this means
			// popping the last non-digit character that was added to the stack.
			// We only pop if the stack is not empty. If the stack is empty, it means
			// there are no non-digit characters to the left of the current digit
			// that haven't already been removed. In this case, the digit itself
			// is effectively removed by not being added to the result.
			if len(stack) > 0 {
				stack = stack[:len(stack)-1] // Pop the last element
			}
		} else {
			// If the current character is a non-digit, we add it to our stack.
			// It might be removed later if a digit appears after it.
			stack = append(stack, r) // Push the non-digit character
		}
	}

	// After processing all characters, the remaining characters in the stack
	// form the final string.
	var sb strings.Builder
	for _, r := range stack {
		sb.WriteRune(r)
	}

	return sb.String()
}