func canTransform(start string, end string) bool {
    if count(start, 'L') != count(end, 'L') || count(start, 'R') != count(end, 'R') {
        return false
    }

    n := len(start)
    i, j := 0, 0

    for i < n || j < n {
        for i < n && start[i] == 'X' {
            i++
        }
        for j < n && end[j] == 'X' {
            j++
        }
        if i < n && j < n {
            if start[i] != end[j] {
                return false
            }
            if start[i] == 'L' && i < j {
                return false
            }
            if start[i] == 'R' && i > j {
                return false
            }
            i++
            j++
        } else if (i < n && start[i] != 'X') || (j < n && end[j] != 'X') {
            return false
        }
    }
    return true
}

func count(s string, char byte) int {
    count := 0
    for i := range s {
        if s[i] == char {
            count++
        }
    }
    return count
}