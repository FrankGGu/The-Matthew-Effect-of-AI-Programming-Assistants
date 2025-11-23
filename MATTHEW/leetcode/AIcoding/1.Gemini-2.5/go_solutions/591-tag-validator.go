package main

func isValid(code string) bool {
	n := len(code)
	stack := []string{}
	hasRootTag := false

	i := 0
	for i < n {
		if i+1 < n && code[i] == '<' {
			if i+2 < n && code[i+1] == '/' { // Closing tag
				j := i + 2
				for j < n && code[j] != '>' {
					j++
				}
				if j == n { // No closing '>'
					return false
				}
				tagName := code[i+2 : j]
				if !isValidTagName(tagName) {
					return false
				}
				if len(stack) == 0 || stack[len(stack)-1] != tagName {
					return false
				}
				stack = stack[:len(stack)-1] // Pop
				i = j + 1
				if len(stack) == 0 && i < n { // Root tag closed, but there's more content
					return false
				}
			} else if i+9 <= n && code[i:i+9] == "<![CDATA[" { // CDATA
				if len(stack) == 0 { // CDATA outside any tag
					return false
				}
				j := i + 9
				for j+2 < n && code[j:j+3] != "]]>" {
					j++
				}
				if j+2 == n { // No closing "]]>"
					return false
				}
				i = j + 3
			} else { // Opening tag
				j := i + 1
				for j < n && code[j] != '>' {
					j++
				}
				if j == n { // No closing '>'
					return false
				}
				tagName := code[i+1 : j]
				if !isValidTagName(tagName) {
					return false
				}
				stack = append(stack, tagName) // Push
				hasRootTag = true
				i = j + 1
			}
		} else { // Plain text
			if len(stack) == 0 { // Plain text outside any tag
				return false
			}
			i++
		}
	}

	return hasRootTag && len(stack) == 0
}

func isValidTagName(tagName string) bool {
	l := len(tagName)
	if l < 1 || l > 9 {
		return false
	}
	for _, r := range tagName {
		if r < 'A' || r > 'Z' {
			return false
		}
	}
	return true
}