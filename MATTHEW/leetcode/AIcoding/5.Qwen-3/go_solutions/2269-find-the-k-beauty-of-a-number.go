package main

func divisorSubstrings(n int, k int) int {
    s := strconv.Itoa(n)
    count := 0
    for i := 0; i <= len(s)-k; i++ {
        substring := s[i : i+k]
        num, _ := strconv.Atoi(substring)
        if n%num == 0 {
            count++
        }
    }
    return count
}