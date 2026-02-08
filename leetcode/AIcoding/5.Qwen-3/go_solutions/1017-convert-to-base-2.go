package main

func baseNeg2(n int) string {
    if n == 0 {
        return "0"
    }
    var res []byte
    for n != 0 {
        remainder := n % -2
        n /= -2
        if remainder < 0 {
            remainder += 2
            n++
        }
        res = append(res, '0'+byte(remainder))
    }
    for i, j := 0, len(res)-1; i < j; i, j = i+1, j-1 {
        res[i], res[j] = res[j], res[i]
    }
    return string(res)
}