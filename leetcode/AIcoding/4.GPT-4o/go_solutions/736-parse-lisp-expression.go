import (
    "fmt"
    "strings"
)

func evaluate(expression string) string {
    return helper(expression)[0]
}

func helper(exp string) []string {
    exp = strings.TrimSpace(exp)
    if exp[0] != '(' {
        return []string{exp}
    }
    stack := []string{}
    i, n := 0, len(exp)
    for i < n {
        if exp[i] == '(' {
            j := i + 1
            cnt := 1
            for cnt > 0 {
                if exp[j] == '(' {
                    cnt++
                } else if exp[j] == ')' {
                    cnt--
                }
                j++
            }
            stack = append(stack, helper(exp[i:j])...)
            i = j
        } else if exp[i] == ' ' {
            i++
        } else {
            j := i
            for j < n && exp[j] != ' ' && exp[j] != '(' && exp[j] != ')' {
                j++
            }
            stack = append(stack, exp[i:j])
            i = j
        }
    }
    return evalStack(stack)
}

func evalStack(stack []string) []string {
    if len(stack) == 0 {
        return []string{}
    }
    cmd := stack[0]
    if cmd == "add" {
        return []string{strconv.Itoa(parseInt(stack[1]) + parseInt(stack[2]))}
    } else if cmd == "mult" {
        return []string{strconv.Itoa(parseInt(stack[1]) * parseInt(stack[2]))}
    } else {
        return []string{cmd}
    }
}

func parseInt(s string) int {
    res, _ := strconv.Atoi(s)
    return res
}