import (
	"strconv"
	"strings"
)

func minimizeResult(expression string) string {
	plusIndex := strings.Index(expression, "+")
	left := expression[:plusIndex]
	right := expression[plusIndex+1:]
	minVal := -1
	res := ""

	for i := 0; i < len(left); i++ {
		for j := 1; j <= len(right); j++ {
			var curVal int
			var leftVal int
			if i == 0 {
				leftVal = 1
			} else {
				num, _ := strconv.Atoi(left[:i])
				leftVal = num
			}

			var rightVal int
			if j == len(right) {
				rightVal = 1
			} else {
				num, _ := strconv.Atoi(right[j:])
				rightVal = num
			}

			num1, _ := strconv.Atoi(left[i:])
			num2, _ := strconv.Atoi(right[:j])

			curVal = leftVal * (num1 + num2) * rightVal

			if minVal == -1 || curVal < minVal {
				minVal = curVal
				res = expression[:i] + "(" + expression[i:plusIndex] + "+" + expression[plusIndex+1:plusIndex+1+j] + ")" + expression[plusIndex+1+j:]
			}
		}
	}

	return res
}