func countAndSay(n int) string {
    if n == 1 {
        return "1"
    }

    prev := countAndSay(n - 1)
    result := ""
    count := 1

    for i := 1; i < len(prev); i++ {
        if prev[i] == prev[i-1] {
            count++
        } else {
            result += fmt.Sprintf("%d%c", count, prev[i-1])
            count = 1
        }
    }

    result += fmt.Sprintf("%d%c", count, prev[len(prev)-1])
    return result
}