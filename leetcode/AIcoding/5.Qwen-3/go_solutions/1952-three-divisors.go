package main

func isThree(n int) bool {
    if n < 2 {
        return false
    }
    count := 0
    for i := 1; i*i <= n; i++ {
        if n%i == 0 {
            if i*i == n {
                count++
            } else {
                count += 2
            }
        }
    }
    return count == 3
}