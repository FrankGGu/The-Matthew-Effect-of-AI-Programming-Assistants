import (
	"fmt"
	"strings"
)

func isValid(code string) bool {
	if len(code) < 3 {
		return false
	}

	stack := []string{}
	i := 0
	for i < len(code) {
		if code[i] == '<' {
			if i+1 < len(code) && code[i+1] == '/' {
				j := i + 2
				for j < len(code) && code[j] != '>' {
					j++
				}
				if j == len(code) {
					return false
				}
				tagName := code[i+2 : j]
				if len(tagName) < 1 || len(tagName) > 9 {
					return false
				}
				for _, char := range tagName {
					if char < 'A' || char > 'Z' {
						return false
					}
				}
				if len(stack) == 0 {
					return false
				}
				if stack[len(stack)-1] != tagName {
					return false
				}
				stack = stack[:len(stack)-1]
				i = j + 1
			} else if i+1 < len(code) && code[i+1] != '!' {
				j := i + 1
				for j < len(code) && code[j] != '>' {
					j++
				}
				if j == len(code) {
					return false
				}
				tagName := code[i+1 : j]
				if len(tagName) < 1 || len(tagName) > 9 {
					return false
				}
				for _, char := range tagName {
					if char < 'A' || char > 'Z' {
						return false
					}
				}
				stack = append(stack, tagName)
				i = j + 1
			} else if i+8 < len(code) && code[i+1:i+9] == "![CDATA[" {
				j := i + 9
				for j+2 < len(code) && code[j:j+3] != "]]>" {
					j++
				}
				if j+2 >= len(code) {
					return false
				}
				i = j + 3
			} else {
				return false
			}
		} else {
			if len(stack) == 0 {
				return false
			}
			i++
		}
	}

	return len(stack) == 0
}