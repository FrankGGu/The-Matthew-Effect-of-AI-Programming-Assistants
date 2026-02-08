package main

func expand(s string) []string {
	var result []string
	var stack []interface{}
	for i := 0; i < len(s); i++ {
		if s[i] == '{' {
			stack = append(stack, i)
		} else if s[i] == '}' {
			start := stack[len(stack)-1].(int)
			stack = stack[:len(stack)-1]
			sub := s[start+1:i]
			elements := make([]string, 0)
			for j := 0; j < len(sub); j++ {
				if sub[j] == ',' {
					elements = append(elements, sub[:j])
					j++
					for j < len(sub) && sub[j] == ' ' {
						j++
					}
					if j < len(sub) {
						startJ := j
						for j < len(sub) && sub[j] != ',' && sub[j] != ' ' {
							j++
						}
						elements = append(elements, sub[startJ:j])
					}
				}
			}
			if len(elements) == 0 {
				elements = append(elements, sub)
			}
			stack = append(stack, elements)
		} else if s[i] != ' ' {
			if len(stack) > 0 {
				top := stack[len(stack)-1]
				if _, ok := top.([]string); ok {
					stack[len(stack)-1] = append(top.([]string), string(s[i]))
				} else {
					stack = append(stack, []string{string(s[i])})
				}
			} else {
				stack = append(stack, []string{string(s[i])})
			}
		}
	}
	result = stack[0].([]string)
	for i := 1; i < len(stack); i++ {
		next := stack[i].([]string)
		newResult := make([]string, 0)
		for _, r := range result {
			for _, n := range next {
				newResult = append(newResult, r+n)
			}
		}
		result = newResult
	}
	return result
}