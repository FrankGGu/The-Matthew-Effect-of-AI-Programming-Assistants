func multiply(num1 string, num2 string) string {
    if num1 == "0" || num2 == "0" {
        return "0"
    }

    m, n := len(num1), len(num2)
    res := make([]int, m+n)

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            mul := int(num1[i]-'0') * int(num2[j]-'0')

            sum := mul + res[i+j+1]

            res[i+j+1] = sum % 10
            res[i+j] += sum / 10
        }
    }

    var resultStr []byte
    leadingZero := true
    for _, digit := range res {
        if leadingZero && digit == 0 {
            continue
        }
        leadingZero = false
        resultStr = append(resultStr, byte(digit+'0'))
    }

    if len(resultStr) == 0 {
        return "0"
    }
    return string(resultStr)
}