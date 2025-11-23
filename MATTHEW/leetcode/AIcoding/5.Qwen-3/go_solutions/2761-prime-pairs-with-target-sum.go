package main

func findPrimePairs(n int) []int {
    if n < 2 {
        return []int{}
    }

    isPrime := make([]bool, n+1)
    for i := range isPrime {
        isPrime[i] = true
    }
    isPrime[0], isPrime[1] = false, false
    for i := 2; i*i <= n; i++ {
        if isPrime[i] {
            for j := i * i; j <= n; j += i {
                isPrime[j] = false
            }
        }
    }

    result := []int{}
    for i := 2; i <= n/2; i++ {
        if isPrime[i] && isPrime[n-i] {
            result = append(result, i)
        }
    }
    return result
}