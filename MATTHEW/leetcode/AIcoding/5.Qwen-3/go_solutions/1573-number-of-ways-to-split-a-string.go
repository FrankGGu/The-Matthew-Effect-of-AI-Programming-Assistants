package main

func numWays(s string) int {
    mod := 1000000007
    count := 0
    for _, c := range s {
        if c == '1' {
            count++
        }
    }
    if count%2 != 0 {
        return 0
    }
    if count == 0 {
        n := len(s)
        return (n-1)*(n-2)/2 % mod
    }
    k := count / 2
    first := 0
    second := 0
    current := 0
    for _, c := range s {
        if c == '1' {
            current++
            if current == k {
                first++
            } else if current == k+1 {
                second++
            }
        }
    }
    return first * second % mod
}