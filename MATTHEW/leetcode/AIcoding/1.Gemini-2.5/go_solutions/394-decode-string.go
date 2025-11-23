package main

import (
	"bytes"
	"strconv"
	"unicode"
)

func decodeString(s string) string {
	numStack := []int{}
	strStack := []string{}
	currentNum := 0
	var currentString bytes.Buffer

	for _, char := range s {
		if unicode.IsDigit(char) {
			currentNum = currentNum*10 + int(char-'0')
		} else if char == '[' {
			strStack = append(strStack, currentString.String())
			numStack = append(numStack, currentNum)
			currentString.Reset()
			currentNum = 0
		} else if char == ']' {
			prevNum := numStack[len(numStack)-1]
			numStack = numStack[:len(numStack)-1]
			prevString := strStack[len(strStack)-1]
			strStack = strStack[:len(strStack)-1]

			var temp bytes.Buffer
			for i := 0; i < prevNum; i++ {
				temp.WriteString(currentString.String())
			}
			currentString.Reset()
			currentString.WriteString(prevString)
			currentString.WriteString(temp.String())
		} else {
			currentString.WriteRune(char)
		}
	}

	return currentString.String()
}