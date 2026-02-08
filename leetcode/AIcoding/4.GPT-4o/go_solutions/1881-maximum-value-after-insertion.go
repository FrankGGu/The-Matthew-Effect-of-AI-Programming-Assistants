func maxValue(n string, x byte) string {
    if n[0] == '-' {
        for i := 1; i < len(n); i++ {
            if n[i] > x {
                return n[:i] + string(x) + n[i:]
            }
        }
        return n + string(x)
    }
    for i := 0; i < len(n); i++ {
        if n[i] < x {
            return n[:i] + string(x) + n[i:]
        }
    }
    return n + string(x)
}