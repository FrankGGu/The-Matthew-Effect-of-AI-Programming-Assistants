package main

func minOperationsToMakeEqual(a, b, c int) int {
    target := 0
    for a != target || b != target || c != target {
        if a > target {
            a--
        } else if a < target {
            a++
        }
        if b > target {
            b--
        } else if b < target {
            b++
        }
        if c > target {
            c--
        } else if c < target {
            c++
        }
    }
    return 0
}