func parseLisp(expression string) int {
	var eval func(string) int
	var parse func(string) ([]string, int)

	parse = func(s string) ([]string, int) {
		res := []string{}
		i := 1
		for i < len(s)-1 {
			if s[i] == '(' {
				cnt := 1
				j := i + 1
				for j < len(s)-1 {
					if s[j] == '(' {
						cnt++
					} else if s[j] == ')' {
						cnt--
					}
					if cnt == 0 {
						break
					}
					j++
				}
				res = append(res, s[i:j+1])
				i = j + 1
			} else if s[i] == ' ' {
				i++
			} else {
				j := i
				for j < len(s)-1 && s[j] != ' ' {
					j++
				}
				res = append(res, s[i:j])
				i = j
			}
		}
		return res, i
	}

	eval = func(expression string) int {
		if expression[0] != '(' {
			val, _ := strconv.Atoi(expression)
			return val
		}

		tokens, _ := parse(expression)
		op := tokens[0]

		if op == "let" {
			vars := map[string]int{}
			for i := 1; i < len(tokens)-1; i += 2 {
				vars[tokens[i]] = eval(tokens[i+1])
			}
			newVars := map[string]int{}
			for k, v := range vars {
				newVars[k] = v
			}
			return eval(tokens[len(tokens)-1])
		} else if op == "add" {
			return eval(tokens[1]) + eval(tokens[2])
		} else if op == "mult" {
			return eval(tokens[1]) * eval(tokens[2])
		} else {
			val, _ := strconv.Atoi(expression)
			return val
		}
	}

	type Env struct {
		vars map[string]int
		prev *Env
	}

	var evalWithEnv func(string, *Env) int

	evalWithEnv = func(expression string, env *Env) int {
		if expression[0] != '(' {
			if val, err := strconv.Atoi(expression); err == nil {
				return val
			} else {
				for e := env; e != nil; e = e.prev {
					if v, ok := e.vars[expression]; ok {
						return v
					}
				}
				return 0
			}
		}

		tokens, _ := parse(expression)
		op := tokens[0]

		if op == "let" {
			newEnv := &Env{vars: make(map[string]int), prev: env}
			i := 1
			for ; i < len(tokens)-1; i += 2 {
				newEnv.vars[tokens[i]] = evalWithEnv(tokens[i+1], newEnv)
			}
			return evalWithEnv(tokens[i], newEnv)
		} else if op == "add" {
			return evalWithEnv(tokens[1], env) + evalWithEnv(tokens[2], env)
		} else if op == "mult" {
			return evalWithEnv(tokens[1], env) * evalWithEnv(tokens[2], env)
		} else {
			val, _ := strconv.Atoi(expression)
			return val
		}
	}

	return evalWithEnv(expression, &Env{vars: make(map[string]int), prev: nil})
}