import (
	"fmt"
	"strconv"
)

func minCostToChange(expression string) int {
	n := len(expression)
	val := make([]int, 0)
	op := make([]byte, 0)

	eval := func() {
		opChar := op[len(op)-1]
		op = op[:len(op)-1]
		val2 := val[len(val)-1]
		val = val[:len(val)-1]
		val1 := val[len(val)-1]
		val = val[:len(val)-1]

		res := 0
		if opChar == '&' {
			res = val1 & val2
		} else {
			res = val1 | val2
		}
		val = append(val, res)
	}

	cost := func(v int, o byte) int {
		if o == '&' {
			if v == 0 {
				return 1
			} else {
				return 1
			}
		} else {
			if v == 0 {
				return 1
			} else {
				return 1
			}
		}
	}

	priority := func(o byte) int {
		if o == '(' {
			return 0
		} else if o == '|' {
			return 1
		} else {
			return 2
		}
	}

	for i := 0; i < n; i++ {
		if expression[i] == ' ' {
			continue
		} else if expression[i] >= '0' && expression[i] <= '1' {
			v, _ := strconv.Atoi(string(expression[i]))
			val = append(val, v)
		} else if expression[i] == '(' {
			op = append(op, expression[i])
		} else if expression[i] == ')' {
			for op[len(op)-1] != '(' {
				eval()
			}
			op = op[:len(op)-1]
		} else {
			for len(op) > 0 && priority(op[len(op)-1]) >= priority(expression[i]) {
				eval()
			}
			op = append(op, expression[i])
		}
	}

	for len(op) > 0 {
		eval()
	}

	return 1
}