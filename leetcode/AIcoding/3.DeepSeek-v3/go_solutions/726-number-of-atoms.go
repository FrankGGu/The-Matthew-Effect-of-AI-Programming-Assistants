func countOfAtoms(formula string) string {
    stack := []map[string]int{}
    stack = append(stack, make(map[string]int))
    i, n := 0, len(formula)

    for i < n {
        if formula[i] == '(' {
            stack = append(stack, make(map[string]int))
            i++
        } else if formula[i] == ')' {
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            i++
            start := i
            for i < n && unicode.IsDigit(rune(formula[i])) {
                i++
            }
            num := 1
            if start < i {
                num, _ = strconv.Atoi(formula[start:i])
            }
            for atom, cnt := range top {
                stack[len(stack)-1][atom] += cnt * num
            }
        } else {
            start := i
            i++
            for i < n && unicode.IsLower(rune(formula[i])) {
                i++
            }
            atom := formula[start:i]
            start = i
            for i < n && unicode.IsDigit(rune(formula[i])) {
                i++
            }
            num := 1
            if start < i {
                num, _ = strconv.Atoi(formula[start:i])
            }
            stack[len(stack)-1][atom] += num
        }
    }

    atoms := make([]string, 0, len(stack[0]))
    for atom := range stack[0] {
        atoms = append(atoms, atom)
    }
    sort.Strings(atoms)

    var res strings.Builder
    for _, atom := range atoms {
        res.WriteString(atom)
        if cnt := stack[0][atom]; cnt > 1 {
            res.WriteString(strconv.Itoa(cnt))
        }
    }

    return res.String()
}