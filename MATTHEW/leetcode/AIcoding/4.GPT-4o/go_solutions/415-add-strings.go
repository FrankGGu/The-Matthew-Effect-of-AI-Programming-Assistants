func addStrings(num1 string, num2 string) string {
    var result strings.Builder
    carry := 0
    i, j := len(num1)-1, len(num2)-1

    for i >= 0 || j >= 0 || carry > 0 {
        sum := carry
        if i >= 0 {
            sum += int(num1[i] - '0')
            i--
        }
        if j >= 0 {
            sum += int(num2[j] - '0')
            j--
        }
        result.WriteByte(byte(sum%10 + '0'))
        carry = sum / 10
    }

    // Reverse the result
    res := result.String()
    n := len(res)
    for k := 0; k < n/2; k++ {
        res[k], res[n-1-k] = res[n-1-k], res[k]
    }

    return res
}