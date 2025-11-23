package main

func parse(expression string) []interface{} {
	type Token struct {
		Type  string
		Value interface{}
	}

	tokens := tokenize(expression)
	return evaluate(tokens, nil)
}

func tokenize(s string) []Token {
	var tokens []Token
	i := 0
	for i < len(s) {
		if s[i] == ' ' {
			i++
			continue
		}
		if s[i] == '(' || s[i] == ')' {
			tokens = append(tokens, Token{Type: "PAREN", Value: s[i]})
			i++
			continue
		}
		if s[i] == '-' && (i == 0 || s[i-1] == ' ' || s[i-1] == '(') {
			i++
			j := i
			for j < len(s) && (s[j] >= '0' && s[j] <= '9') {
				j++
			}
			if j > i {
				tokens = append(tokens, Token{Type: "NUMBER", Value: s[i:j]})
				i = j
				continue
			}
		}
		if s[i] >= '0' && s[i] <= '9' {
			j := i
			for j < len(s) && s[j] >= '0' && s[j] <= '9' {
				j++
			}
			tokens = append(tokens, Token{Type: "NUMBER", Value: s[i:j]})
			i = j
			continue
		}
		if s[i] >= 'a' && s[i] <= 'z' {
			j := i
			for j < len(s) && (s[j] >= 'a' && s[j] <= 'z') {
				j++
			}
			tokens = append(tokens, Token{Type: "SYMBOL", Value: s[i:j]})
			i = j
			continue
		}
		i++
	}
	return tokens
}

func evaluate(tokens []Token, env map[string]interface{}) []interface{} {
	if len(tokens) == 0 {
		return nil
	}
	if tokens[0].Type == "PAREN" && tokens[0].Value == '(' {
		tokens = tokens[1:]
	}
	if tokens[0].Type == "SYMBOL" && tokens[0].Value == "let" {
		return evalLet(tokens, env)
	}
	if tokens[0].Type == "SYMBOL" && tokens[0].Value == "add" {
		return evalAdd(tokens, env)
	}
	if tokens[0].Type == "SYMBOL" && tokens[0].Value == "mult" {
		return evalMult(tokens, env)
	}
	if tokens[0].Type == "NUMBER" {
		return []interface{}{tokens[0].Value}
	}
	if tokens[0].Type == "SYMBOL" {
		return []interface{}{env[tokens[0].Value.(string)]}
	}
	return nil
}

func evalLet(tokens []Token, env map[string]interface{}) []interface{} {
	newEnv := make(map[string]interface{})
	newEnv = env
	for {
		if len(tokens) == 0 {
			break
		}
		if tokens[0].Type == "PAREN" && tokens[0].Value == ")" {
			tokens = tokens[1:]
			break
		}
		if tokens[0].Type == "SYMBOL" {
			symbol := tokens[0].Value.(string)
			tokens = tokens[1:]
			if tokens[0].Type == "PAREN" && tokens[0].Value == "(" {
				val := evaluate(tokens, newEnv)
				newEnv[symbol] = val[0]
				tokens = tokens[len(val)-1:]
			} else {
				val := evaluate(tokens, newEnv)
				newEnv[symbol] = val[0]
				tokens = tokens[len(val)-1:]
			}
		} else {
			break
		}
	}
	return evaluate(tokens, newEnv)
}

func evalAdd(tokens []Token, env map[string]interface{}) []interface{} {
	tokens = tokens[1:]
	left := evaluate(tokens, env)
	tokens = tokens[len(left)-1:]
	right := evaluate(tokens, env)
	tokens = tokens[len(right)-1:]
	return []interface{}{left[0].(int) + right[0].(int)}
}

func evalMult(tokens []Token, env map[string]interface{}) []interface{} {
	tokens = tokens[1:]
	left := evaluate(tokens, env)
	tokens = tokens[len(left)-1:]
	right := evaluate(tokens, env)
	tokens = tokens[len(right)-1:]
	return []interface{}{left[0].(int) * right[0].(int)}
}