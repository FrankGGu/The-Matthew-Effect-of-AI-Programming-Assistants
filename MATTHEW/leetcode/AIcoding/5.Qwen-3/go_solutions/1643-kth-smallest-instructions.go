package main

func kthSmallestInstruction(a, b, k int) string {
    var res []byte
    for a > 0 && b > 0 {
        cnt := comb(a + b - 1, a - 1)
        if k > cnt {
            res = append(res, 'H')
            b--
            k -= cnt
        } else {
            res = append(res, 'V')
            a--
        }
    }
    for a > 0 {
        res = append(res, 'V')
        a--
    }
    for b > 0 {
        res = append(res, 'H')
        b--
    }
    return string(res)
}

func comb(n, k int) int {
    if k > n-k {
        k = n - k
    }
    result := 1
    for i := 0; i < k; i++ {
        result *= (n - i)
        result /= (i + 1)
    }
    return result
}