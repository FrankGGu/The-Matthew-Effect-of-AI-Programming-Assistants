func movesToStamp(stamp string, target string) []int {
    m, n := len(target), len(stamp)
    visited := make([]bool, m)
    result := []int{}

    canStamp := func(start int) bool {
        count := 0
        for i := 0; i < n && start+i < m; i++ {
            if visited[start+i] {
                count++
                continue
            }
            if stamp[i] == target[start+i] {
                count++
            }
        }
        return count > 0 && count+n > 0
    }

    stampAt := func(start int) {
        for i := 0; i < n && start+i < m; i++ {
            if !visited[start+i] && stamp[i] == target[start+i] {
                visited[start+i] = true
            }
        }
    }

    for {
        stamped := false
        for i := 0; i <= m-n; i++ {
            if !visited[i] && canStamp(i) {
                stampAt(i)
                result = append(result, i)
                stamped = true
            }
        }
        if !stamped {
            break
        }
    }

    for _, v := range visited {
        if !v {
            return []int{}
        }
    }

    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }
    return result
}