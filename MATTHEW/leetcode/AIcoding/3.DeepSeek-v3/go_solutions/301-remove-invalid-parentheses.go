func removeInvalidParentheses(s string) []string {
    var res []string
    queue := []string{s}
    visited := map[string]bool{s: true}
    found := false

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        if isValid(current) {
            res = append(res, current)
            found = true
        }

        if found {
            continue
        }

        for i := 0; i < len(current); i++ {
            if current[i] != '(' && current[i] != ')' {
                continue
            }

            next := current[:i] + current[i+1:]
            if !visited[next] {
                visited[next] = true
                queue = append(queue, next)
            }
        }
    }

    if len(res) == 0 {
        return []string{""}
    }
    return res
}

func isValid(s string) bool {
    count := 0
    for _, ch := range s {
        if ch == '(' {
            count++
        } else if ch == ')' {
            count--
            if count < 0 {
                return false
            }
        }
    }
    return count == 0
}