import "strconv"

func diffWaysToCompute(expression string) []int {
	var res []int
	for i, c := range expression {
		if c == '+' || c == '-' || c == '*' {
			left := diffWaysToCompute(expression[:i])
			right := diffWaysToCompute(expression[i+1:])
			for _, l := range left {
				for _, r := range right {
					switch c {
					case '+':
						res = append(res, l+r)
					case '-':
						res = append(res, l-r)
					case '*':
						res = append(res, l*r)
					}
				}
			}
		}
	}
	if len(res) == 0 {
		num, _ := strconv.Atoi(expression)
		res = append(res, num)
	}
	return res
}