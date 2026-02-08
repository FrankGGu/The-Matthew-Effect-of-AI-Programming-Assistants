func separateNumbers(s string) string {
    n := len(s)
    for i := 1; i <= n/2; i++ {
        firstNum := s[:i]
        currentNum := firstNum
        pos := i
        for pos < n {
            currentNum = increment(currentNum)
            nextLength := len(currentNum)
            if pos+nextLength > n || s[pos:pos+nextLength] != currentNum {
                break
            }
            pos += nextLength
        }
        if pos == n {
            return "YES " + firstNum
        }
    }
    return "NO"
}

func increment(num string) string {
    n := len(num)
    carry := 1
    result := make([]byte, n)
    for i := n - 1; i >= 0; i-- {
        digit := int(num[i]-'0') + carry
        if digit == 10 {
            result[i] = '0'
            carry = 1
        } else {
            result[i] = byte(digit + '0')
            carry = 0
            break
        }
    }
    if carry == 1 {
        return "1" + string(result)
    }
    return string(result)
}