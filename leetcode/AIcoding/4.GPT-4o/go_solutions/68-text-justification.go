package main

import (
	"fmt"
	"strings"
)

func fullJustify(words []string, maxWidth int) []string {
	result := []string{}
	line := []string{}
	lineLength := 0

	for _, word := range words {
		if lineLength+len(word)+len(line) > maxWidth {
			result = append(result, justifyLine(line, lineLength, maxWidth))
			line = []string{word}
			lineLength = len(word)
		} else {
			line = append(line, word)
			lineLength += len(word)
		}
	}

	if len(line) > 0 {
		result = append(result, justifyLastLine(line, maxWidth))
	}

	return result
}

func justifyLine(line []string, lineLength, maxWidth int) string {
	if len(line) == 1 {
		return line[0] + strings.Repeat(" ", maxWidth-len(line[0]))
	}

	spaces := maxWidth - lineLength
	gaps := len(line) - 1
	spaceBetweenWords := spaces / gaps
	extraSpaces := spaces % gaps

	var sb strings.Builder
	for i, word := range line {
		sb.WriteString(word)
		if i < gaps {
			sb.WriteString(strings.Repeat(" ", spaceBetweenWords))
			if i < extraSpaces {
				sb.WriteString(" ")
			}
		}
	}
	return sb.String()
}

func justifyLastLine(line []string, maxWidth int) string {
	return strings.Join(line, " ") + strings.Repeat(" ", maxWidth-len(strings.Join(line, " ")))
}

func main() {
	// Example usage
	words := []string{"This", "is", "an", "example", "of", "text", "justification."}
	maxWidth := 16
	result := fullJustify(words, maxWidth)
	for _, line := range result {
		fmt.Println(line)
	}
}