package main

func decrypt(password string, target int) string {
    n := len(password)
    result := make([]byte, n)
    for i := 0; i < n; i++ {
        if target == 0 {
            result[i] = password[i]
        } else if target > 0 {
            result[i] = password[(i+target)%n]
        } else {
            result[i] = password[(i+target+n)%n]
        }
    }
    return string(result)
}