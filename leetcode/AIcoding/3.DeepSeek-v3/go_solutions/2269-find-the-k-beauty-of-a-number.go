func divisorSubstrings(num int, k int) int {
    s := strconv.Itoa(num)
    count := 0
    for i := 0; i <= len(s)-k; i++ {
        sub := s[i : i+k]
        n, _ := strconv.Atoi(sub)
        if n != 0 && num%n == 0 {
            count++
        }
    }
    return count
}