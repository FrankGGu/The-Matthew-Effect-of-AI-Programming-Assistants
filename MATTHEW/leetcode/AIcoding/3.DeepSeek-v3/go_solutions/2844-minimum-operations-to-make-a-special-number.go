func minimumOperations(num string) int {
    n := len(num)
    res := n
    for i := n - 1; i >= 0; i-- {
        if num[i] == '0' {
            for j := i - 1; j >= 0; j-- {
                if num[j] == '0' || num[j] == '5' {
                    res = min(res, (i-j-1) + (n-i-1))
                }
            }
            res = min(res, n-1)
        } else if num[i] == '5' {
            for j := i - 1; j >= 0; j-- {
                if num[j] == '2' || num[j] == '7' {
                    res = min(res, (i-j-1) + (n-i-1))
                }
            }
        }
    }
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}