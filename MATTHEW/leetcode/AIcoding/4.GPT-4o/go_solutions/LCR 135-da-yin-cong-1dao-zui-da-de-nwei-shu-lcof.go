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
            result += strconv.Itoa(count) + string(prev[i-1])
            count = 1
        }
    }
    result += strconv.Itoa(count) + string(prev[len(prev)-1])
    return result
}