func magicalString(n int) int {
    if n == 0 {
        return 0
    }
    if n <= 3 {
        return 1
    }
    s := make([]int, n+1)
    s[0], s[1], s[2] = 1, 2, 2
    res := 1
    head := 2
    tail := 3
    num := 1
    for tail < n {
        for i := 0; i < s[head]; i++ {
            s[tail] = num
            if num == 1 && tail < n {
                res++
            }
            tail++
        }
        num ^= 3
        head++
    }
    return res
}