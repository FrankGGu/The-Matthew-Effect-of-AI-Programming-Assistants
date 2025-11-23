package main

import (
	"strings"
)

func decodeMessage(key string, message string) string {
	mapping := make(map[rune]rune)
	nextChar := 'a'

	for _, kChar := range key {
		if kChar == ' ' {
			continue
		}
		if _, found := mapping[kChar]; !found {
			mapping[kChar] = nextChar
			nextChar++
			if nextChar > 'z' {
				break
			}
		}
	}

	var decodedMessage strings.Builder
	decodedMessage.Grow(len(message))

	for _, mChar := range message {
		if mChar == ' ' {
			decodedMessage.WriteRune(' ')
		} else {
			decodedMessage.WriteRune(mapping[mChar])
		}
	}

	return decodedMessage.String()
}