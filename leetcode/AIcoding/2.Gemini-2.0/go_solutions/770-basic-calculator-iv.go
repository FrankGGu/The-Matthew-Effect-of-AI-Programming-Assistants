import (
	"fmt"
	"strconv"
	"strings"
)

func basicCalculatorIV(expression string, evalvars []string, evalints []int) []string {
	env := make(map[string]int)
	for i := 0; i < len(evalvars); i++ {
		env[evalvars[i]] = evalints[i]
	}

	tokens := tokenize(expression)
	res := evaluate(tokens, env)

	var ans []string
	for degree := 200; degree >= 0; degree-- {
		if poly, ok := res[degree]; ok {
			for varStr, coeff := range poly {
				if coeff != 0 {
					if varStr == "" {
						ans = append(ans, fmt.Sprintf("%d", coeff))
					} else {
						vars := strings.Split(varStr, "*")
						sort.Strings(vars)
						varStr = strings.Join(vars, "*")
						if coeff == 1 {
							ans = append(ans, varStr)
						} else {
							ans = append(ans, fmt.Sprintf("%d*%s", coeff, varStr))
						}
					}
				}
			}
		}
	}
	if len(ans) == 0 {
		ans = append(ans, "0")
	}

	return ans
}

func tokenize(expression string) []string {
	tokens := make([]string, 0)
	var sb strings.Builder
	for _, char := range expression {
		if char == ' ' {
			if sb.Len() > 0 {
				tokens = append(tokens, sb.String())
				sb.Reset()
			}
		} else if char == '(' || char == ')' || char == '+' || char == '-' || char == '*' {
			if sb.Len() > 0 {
				tokens = append(tokens, sb.String())
				sb.Reset()
			}
			tokens = append(tokens, string(char))
		} else {
			sb.WriteRune(char)
		}
	}
	if sb.Len() > 0 {
		tokens = append(tokens, sb.String())
	}
	return tokens
}

func evaluate(tokens []string, env map[string]int) map[int]map[string]int {
	values := make([]map[int]map[string]int, 0)
	ops := make([]string, 0)

	apply := func(op string) {
		v2 := values[len(values)-1]
		v1 := values[len(values)-2]
		values = values[:len(values)-2]
		var res map[int]map[string]int
		if op == "+" {
			res = add(v1, v2)
		} else if op == "-" {
			res = subtract(v1, v2)
		} else if op == "*" {
			res = multiply(v1, v2)
		}
		values = append(values, res)
	}

	for _, token := range tokens {
		switch token {
		case "(":
			ops = append(ops, token)
		case "+", "-":
			for len(ops) > 0 && (ops[len(ops)-1] == "*" || ops[len(ops)-1] == "+" || ops[len(ops)-1] == "-") {
				apply(ops[len(ops)-1])
				ops = ops[:len(ops)-1]
			}
			ops = append(ops, token)
		case "*":
			for len(ops) > 0 && ops[len(ops)-1] == "*" {
				apply(ops[len(ops)-1])
				ops = ops[:len(ops)-1]
			}
			ops = append(ops, token)
		case ")":
			for ops[len(ops)-1] != "(" {
				apply(ops[len(ops)-1])
				ops = ops[:len(ops)-1]
			}
			ops = ops[:len(ops)-1]
		default:
			val, err := strconv.Atoi(token)
			if err == nil {
				values = append(values, map[int]map[string]int{0: {"": val}})
			} else {
				if num, ok := env[token]; ok {
					values = append(values, map[int]map[string]int{0: {"": num}})
				} else {
					values = append(values, map[int]map[string]int{1: {token: 1}})
				}
			}
		}
	}

	for len(ops) > 0 {
		apply(ops[len(ops)-1])
		ops = ops[:len(ops)-1]
	}

	return values[0]
}

func add(v1, v2 map[int]map[string]int) map[int]map[string]int {
	res := make(map[int]map[string]int)
	for degree, poly := range v1 {
		for varStr, coeff := range poly {
			if _, ok := res[degree]; !ok {
				res[degree] = make(map[string]int)
			}
			res[degree][varStr] += coeff
		}
	}
	for degree, poly := range v2 {
		for varStr, coeff := range poly {
			if _, ok := res[degree]; !ok {
				res[degree] = make(map[string]int)
			}
			res[degree][varStr] += coeff
		}
	}
	return res
}

func subtract(v1, v2 map[int]map[string]int) map[int]map[string]int {
	res := make(map[int]map[string]int)
	for degree, poly := range v1 {
		for varStr, coeff := range poly {
			if _, ok := res[degree]; !ok {
				res[degree] = make(map[string]int)
			}
			res[degree][varStr] += coeff
		}
	}
	for degree, poly := range v2 {
		for varStr, coeff := range poly {
			if _, ok := res[degree]; !ok {
				res[degree] = make(map[string]int)
			}
			res[degree][varStr] -= coeff
		}
	}
	return res
}

func multiply(v1, v2 map[int]map[string]int) map[int]map[string]int {
	res := make(map[int]map[string]int)
	for degree1, poly1 := range v1 {
		for varStr1, coeff1 := range poly1 {
			for degree2, poly2 := range v2 {
				for varStr2, coeff2 := range poly2 {
					degree := degree1 + degree2
					varStr := ""
					if varStr1 != "" {
						varStr = varStr1
					}
					if varStr2 != "" {
						if varStr != "" {
							varStr += "*"
						}
						varStr += varStr2
					}
					coeff := coeff1 * coeff2
					if _, ok := res[degree]; !ok {
						res[degree] = make(map[string]int)
					}
					res[degree][varStr] += coeff
				}
			}
		}
	}
	return res
}

import "sort"