package main

func generateTheString(n int) string {
    s := make([]byte, n)
    for i := 0; i < n; i++ {
        s[i] = 'a'
    }
    if n%2 == 0 {
        s[0] = 'b'
    }
    return string(s)
}