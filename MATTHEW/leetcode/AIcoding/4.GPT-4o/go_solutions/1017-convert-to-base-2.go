func baseNeg2(N int) string {
    if N == 0 {
        return "0"
    }
    result := ""
    for N != 0 {
        remainder := N % -2
        N /= -2
        if remainder < 0 {
            remainder += 2
            N++
        }
        result = strconv.Itoa(remainder) + result
    }
    return result
}