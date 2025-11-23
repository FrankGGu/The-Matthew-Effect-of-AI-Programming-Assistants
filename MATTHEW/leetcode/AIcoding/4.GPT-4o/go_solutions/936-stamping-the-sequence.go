func movesToStamp(stamp string, target string) []int {
    m, n := len(stamp), len(target)
    visited := make([]bool, n)
    res := []int{}
    canStamp := make([]bool, n)

    var canReplace func(start int) bool
    canReplace = func(start int) bool {
        count := 0
        for i := 0; i < m; i++ {
            if start+i >= n {
                return false
            }
            if visited[start+i] {
                continue
            }
            if stamp[i] == target[start+i] {
                count++
            } else if count == 0 {
                return false
            }
        }
        return count > 0
    }

    for count := 0; count < n; {
        for i := 0; i <= n-m; i++ {
            if !visited[i] && canReplace(i) {
                for j := 0; j < m; j++ {
                    visited[i+j] = true
                }
                res = append(res, i)
                count += m
            }
        }
    }

    if count < n {
        return []int{}
    }

    for i, j := 0, len(res)-1; i < j; i, j = i+1, j-1 {
        res[i], res[j] = res[j], res[i]
    }
    return res
}