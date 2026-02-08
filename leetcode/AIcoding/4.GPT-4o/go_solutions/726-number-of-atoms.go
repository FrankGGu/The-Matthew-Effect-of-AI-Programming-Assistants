import (
    "fmt"
    "sort"
    "strconv"
)

func countOfAtoms(formula string) string {
    stack := []map[string]int{{}}
    i := 0
    n := len(formula)

    for i < n {
        if formula[i] == '(' {
            stack = append(stack, map[string]int{})
            i++
        } else if formula[i] == ')' {
            i++
            j := i
            for j < n && formula[j] >= '0' && formula[j] <= '9' {
                j++
            }
            multiplier := 1
            if j > i {
                multiplier, _ = strconv.Atoi(formula[i:j])
                i = j
            }
            top := stack[len(stack)-1]
            stack = stack[:len(stack)-1]
            for atom, count := range top {
                stack[len(stack)-1][atom] += count * multiplier
            }
        } else {
            j := i + 1
            for j < n && formula[j] >= 'a' && formula[j] <= 'z' {
                j++
            }
            atom := formula[i:j]
            i = j
            count := 1
            for i < n && formula[i] >= '0' && formula[i] <= '9' {
                i++
            }
            if i > j {
                count, _ = strconv.Atoi(formula[j:i])
            }
            stack[len(stack)-1][atom] += count
        }
    }

    result := []string{}
    for atom, count := range stack[0] {
        result = append(result, fmt.Sprintf("%s%d", atom, count))
    }
    sort.Slice(result, func(i, j int) bool {
        return result[i] < result[j]
    })

    return strings.Join(result, "")
}