package main

func numberOfWays(s string) int {
    n := len(s)
    leftZero := make([]int, n)
    leftOne := make([]int, n)
    rightZero := make([]int, n)
    rightOne := make([]int, n)

    for i := 1; i < n; i++ {
        leftZero[i] = leftZero[i-1]
        leftOne[i] = leftOne[i-1]
        if s[i-1] == '0' {
            leftZero[i]++
        } else {
            leftOne[i]++
        }
    }

    for i := n - 2; i >= 0; i-- {
        rightZero[i] = rightZero[i+1]
        rightOne[i] = rightOne[i+1]
        if s[i+1] == '0' {
            rightZero[i]++
        } else {
            rightOne[i]++
        }
    }

    res := 0
    for i := 1; i < n-1; i++ {
        if s[i] == '0' {
            res += leftOne[i] * rightOne[i]
        } else {
            res += leftZero[i] * rightZero[i]
        }
    }

    return res
}