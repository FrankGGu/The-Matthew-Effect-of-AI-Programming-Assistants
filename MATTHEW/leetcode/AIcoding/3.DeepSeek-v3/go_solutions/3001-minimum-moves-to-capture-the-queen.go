func minMovesToCaptureTheQueen(a int, b int, c int, d int, e int, f int) int {
    if a == e && (c != e || (d < min(b, f) || d > max(b, f))) {
        return 1
    }
    if b == f && (d != f || (c < min(a, e) || c > max(a, e))) {
        return 1
    }
    if abs(c - e) == abs(d - f) {
        if abs(a - c) == abs(b - d) {
            if (a < min(c, e) || a > max(c, e)) || (b < min(d, f) || b > max(d, f)) {
                return 1
            } else {
                return 2
            }
        } else {
            return 1
        }
    }
    if (a == c && b == d) || (c == e && d == f) {
        return 1
    }
    return 2
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}