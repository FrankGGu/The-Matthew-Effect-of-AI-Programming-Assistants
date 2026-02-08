package main

func sumOfPrimeFactors(n int) int {
    if n == 1 {
        return 0
    }
    res := 0
    i := 2
    for i*i <= n {
        for n%i == 0 {
            res += i
            n /= i
        }
        i++
    }
    if n > 1 {
        res += n
    }
    return res
}

func findSmallestValue(n int) int {
    for {
        s := sumOfPrimeFactors(n)
        if s >= n {
            return n
        }
        n = s
    }
}