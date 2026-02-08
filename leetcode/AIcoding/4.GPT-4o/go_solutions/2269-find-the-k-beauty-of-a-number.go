func kBeauty(num int, k int) int {
    s := strconv.Itoa(num)
    n := len(s)
    if k > n {
        return 0
    }
    count := 0
    for i := 0; i <= n-k; i++ {
        sub := s[i : i+k]
        val, _ := strconv.Atoi(sub)
        if val != 0 && num%val == 0 {
            count++
        }
    }
    return count
}