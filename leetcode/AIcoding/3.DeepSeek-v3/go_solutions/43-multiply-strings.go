func multiply(num1 string, num2 string) string {
    if num1 == "0" || num2 == "0" {
        return "0"
    }

    m, n := len(num1), len(num2)
    res := make([]int, m + n)

    for i := m - 1; i >= 0; i-- {
        for j := n - 1; j >= 0; j-- {
            mul := int(num1[i] - '0') * int(num2[j] - '0')
            p1, p2 := i + j, i + j + 1
            sum := mul + res[p2]

            res[p2] = sum % 10
            res[p1] += sum / 10
        }
    }

    var sb strings.Builder
    for _, v := range res {
        if sb.Len() == 0 && v == 0 {
            continue
        }
        sb.WriteByte(byte(v + '0'))
    }

    return sb.String()
}