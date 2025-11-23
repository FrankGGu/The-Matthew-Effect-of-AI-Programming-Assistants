type expr struct {
    terms map[string]int
    constTerm int
}

func (e *expr) addTerm(coef int, vars []string) {
    key := strings.Join(vars, "*")
    e.terms[key] += coef
}

func (e *expr) addConst(c int) {
    e.constTerm += c
}

func (e *expr) add(other *expr) {
    for k, v := range other.terms {
        e.terms[k] += v
    }
    e.constTerm += other.constTerm
}

func (e *expr) sub(other *expr) {
    for k, v := range other.terms {
        e.terms[k] -= v
    }
    e.constTerm -= other.constTerm
}

func (e *expr) mul(other *expr) {
    newTerms := make(map[string]int)
    for k1, v1 := range e.terms {
        for k2, v2 := range other.terms {
            vars1 := strings.Split(k1, "*")
            vars2 := strings.Split(k2, "*")
            newVars := append(vars1, vars2...)
            sort.Strings(newVars)
            newKey := strings.Join(newVars, "*")
            newTerms[newKey] += v1 * v2
        }
    }
    for k, v := range other.terms {
        newTerms[k] += e.constTerm * v
    }
    for k, v := range e.terms {
        newTerms[k] += v * other.constTerm
    }
    e.terms = newTerms
    e.constTerm *= other.constTerm
}

func (e *expr) evaluate(vars map[string]int) int {
    res := e.constTerm
    for k, v := range e.terms {
        parts := strings.Split(k, "*")
        val := 1
        for _, p := range parts {
            val *= vars[p]
        }
        res += v * val
    }
    return res
}

func (e *expr) toList() []string {
    var keys []string
    for k := range e.terms {
        if e.terms[k] != 0 {
            keys = append(keys, k)
        }
    }
    sort.Slice(keys, func(i, j int) bool {
        a := strings.Split(keys[i], "*")
        b := strings.Split(keys[j], "*")
        if len(a) != len(b) {
            return len(a) > len(b)
        }
        return keys[i] < keys[j]
    })
    var res []string
    for _, k := range keys {
        if coef := e.terms[k]; coef != 0 {
            term := fmt.Sprintf("%d", coef)
            if k != "" {
                term += "*" + k
            }
            res = append(res, term)
        }
    }
    if e.constTerm != 0 || len(res) == 0 {
        res = append(res, fmt.Sprintf("%d", e.constTerm))
    }
    return res
}

func parseExpr(s string, vars map[string]int) *expr {
    e := &expr{terms: make(map[string]int)}
    if s[0] != '(' {
        if s[0] >= '0' && s[0] <= '9' {
            num, _ := strconv.Atoi(s)
            e.addConst(num)
        } else {
            if val, ok := vars[s]; ok {
                e.addConst(val)
            } else {
                e.addTerm(1, []string{s})
            }
        }
        return e
    }
    opPos := 1
    for s[opPos] != ' ' {
        opPos++
    }
    op := s[1:opPos]
    left := parseExpr(s[opPos+1:findComma(s, opPos+1)], vars)
    right := parseExpr(s[findComma(s, opPos+1)+1:len(s)-1], vars)
    switch op {
    case "add":
        left.add(right)
    case "sub":
        left.sub(right)
    case "mult":
        left.mul(right)
    }
    return left
}

func findComma(s string, start int) int {
    balance := 0
    for i := start; i < len(s); i++ {
        if s[i] == '(' {
            balance++
        } else if s[i] == ')' {
            balance--
        } else if s[i] == ' ' && balance == 0 {
            return i
        }
    }
    return len(s)
}

func basicCalculatorIV(expression string, evalvars []string, evalints []int) []string {
    vars := make(map[string]int)
    for i := 0; i < len(evalvars); i++ {
        vars[evalvars[i]] = evalints[i]
    }
    e := parseExpr(expression, vars)
    return e.toList()
}