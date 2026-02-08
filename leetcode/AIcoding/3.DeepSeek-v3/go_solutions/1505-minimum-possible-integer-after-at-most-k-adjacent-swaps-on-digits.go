func minInteger(num string, k int) string {
    n := len(num)
    digits := []byte(num)
    pos := make([][]int, 10)
    for i := n - 1; i >= 0; i-- {
        digit := digits[i] - '0'
        pos[digit] = append(pos[digit], i)
    }

    fenwick := make([]int, n+2)
    res := make([]byte, 0, n)

    for i := 0; i < n; i++ {
        for d := 0; d < 10; d++ {
            if len(pos[d]) == 0 {
                continue
            }
            p := pos[d][len(pos[d])-1]
            cost := p - query(fenwick, p)
            if cost <= k {
                k -= cost
                res = append(res, byte(d)+'0')
                update(fenwick, p+1, n)
                pos[d] = pos[d][:len(pos[d])-1]
                break
            }
        }
    }

    return string(res)
}

func update(fenwick []int, index int, n int) {
    for index <= n {
        fenwick[index]++
        index += index & -index
    }
}

func query(fenwick []int, index int) int {
    res := 0
    for index > 0 {
        res += fenwick[index]
        index -= index & -index
    }
    return res
}