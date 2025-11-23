import (
	"sort"
	"strings"
)

func braceExpansionII(expression string) []string {
	res := evaluate(expression)
	sortedRes := make([]string, 0, len(res))
	for s := range res {
		sortedRes = append(sortedRes, s)
	}
	sort.Strings(sortedRes)
	return sortedRes
}

func evaluate(expression string) map[string]bool {
	res := make(map[string]bool)
	if len(expression) == 0 {
		res[""] = true
		return res
	}

	if !strings.Contains(expression, "{") && !strings.Contains(expression, "}") && !strings.Contains(expression, ",") {
		res[expression] = true
		return res
	}

	if !strings.Contains(expression, "{") {
		res[expression] = true
		return res
	}

	stack := []int{}
	for i, char := range expression {
		if char == '{' {
			stack = append(stack, i)
		} else if char == '}' {
			start := stack[len(stack)-1]
			stack = stack[:len(stack)-1]

			options := strings.Split(expression[start+1:i], ",")
			prefix := ""
			if start > 0 {
				prefix = expression[:start]
			}
			suffix := ""
			if i < len(expression)-1 {
				suffix = expression[i+1:]
			}

			prefixRes := evaluate(prefix)
			suffixRes := evaluate(suffix)
			optionRes := []map[string]bool{}

			for _, option := range options {
				optionRes = append(optionRes, evaluate(option))
			}

			for pStr := range prefixRes {
				for sStr := range suffixRes {
					for _, optRes := range optionRes {
						for oStr := range optRes {
							res[pStr+oStr+sStr] = true
						}
					}
				}
			}
			return res
		}
	}

	res[expression] = true
	return res
}