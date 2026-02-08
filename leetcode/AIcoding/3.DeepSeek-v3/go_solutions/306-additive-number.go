func isAdditiveNumber(num string) bool {
    n := len(num)
    for i := 1; i <= n/2; i++ {
        for j := 1; j <= (n-i)/2; j++ {
            if isValid(num, i, j) {
                return true
            }
        }
    }
    return false
}

func isValid(num string, i, j int) bool {
    if num[0] == '0' && i > 1 {
        return false
    }
    if num[i] == '0' && j > 1 {
        return false
    }
    sum := ""
    x1, _ := strconv.Atoi(num[:i])
    x2, _ := strconv.Atoi(num[i : i+j])
    k := i + j
    for k < len(num) {
        x2 = x2 + x1
        x1 = x2 - x1
        sum = strconv.Itoa(x2)
        if !strings.HasPrefix(num[k:], sum) {
            return false
        }
        k += len(sum)
    }
    return true
}