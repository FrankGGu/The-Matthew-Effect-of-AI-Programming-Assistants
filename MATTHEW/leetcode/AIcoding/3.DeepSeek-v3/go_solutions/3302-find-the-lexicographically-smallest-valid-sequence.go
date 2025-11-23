func findLexSmallestString(s string, a int, b int) string {
    n := len(s)
    visited := make(map[string]bool)
    queue := []string{s}
    res := s
    visited[s] = true

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        if current < res {
            res = current
        }

        // Operation 1: Add a to every odd index
        op1 := []byte(current)
        for i := 1; i < n; i += 2 {
            op1[i] = byte((int(op1[i]-'0')+a)%10 + '0')
        }
        s1 := string(op1)
        if !visited[s1] {
            visited[s1] = true
            queue = append(queue, s1)
        }

        // Operation 2: Rotate right by b positions
        op2 := current[n-b:] + current[:n-b]
        if !visited[op2] {
            visited[op2] = true
            queue = append(queue, op2)
        }
    }

    return res
}