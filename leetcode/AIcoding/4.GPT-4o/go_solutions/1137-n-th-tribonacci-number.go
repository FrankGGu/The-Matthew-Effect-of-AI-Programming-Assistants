func tribonacci(n int) int {
    if n == 0 {
        return 0
    } else if n == 1 || n == 2 {
        return 1
    }

    t0, t1, t2 := 0, 1, 1
    for i := 3; i <= n; i++ {
        t := t0 + t1 + t2
        t0, t1, t2 = t1, t2, t
    }
    return t2
}