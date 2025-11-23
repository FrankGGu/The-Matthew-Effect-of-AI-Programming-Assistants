func addStrings(num1 string, num2 string) string {
    res := []byte{}
    i, j := len(num1)-1, len(num2)-1
    carry := 0

    for i >= 0 || j >= 0 || carry > 0 {
        var n1, n2 int
        if i >= 0 {
            n1 = int(num1[i] - '0')
            i--
        }
        if j >= 0 {
            n2 = int(num2[j] - '0')
            j--
        }
        sum := n1 + n2 + carry
        carry = sum / 10
        res = append(res, byte(sum % 10 + '0'))
    }

    for l, r := 0, len(res)-1; l < r; l, r = l+1, r-1 {
        res[l], res[r] = res[r], res[l]
    }

    return string(res)
}