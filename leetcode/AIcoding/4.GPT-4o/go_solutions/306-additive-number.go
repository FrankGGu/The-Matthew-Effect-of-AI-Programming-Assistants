func isAdditiveNumber(num string) bool {
    n := len(num)

    for i := 1; i <= n/2; i++ {
        for j := i + 1; j <= n; j++ {
            if isValid(num[:i], num[i:j], num[j:]) {
                return true
            }
        }
    }
    return false
}

func isValid(first, second, rest string) bool {
    if (len(first) > 1 && first[0] == '0') || (len(second) > 1 && second[0] == '0') {
        return false
    }
    sum := addStrings(first, second)
    if len(rest) < len(sum) || rest[:len(sum)] != sum {
        return false
    }
    if len(rest) == len(sum) {
        return true
    }
    return isValid(second, sum, rest[len(sum):])
}

func addStrings(num1, num2 string) string {
    carry := 0
    result := []byte{}
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
        result = append(result, byte(sum%10+'0'))
        carry = sum / 10
    }

    // Reverse result
    for left, right := 0, len(result)-1; left < right; left, right = left+1, right-1 {
        result[left], result[right] = result[right], result[left]
    }
    return string(result)
}