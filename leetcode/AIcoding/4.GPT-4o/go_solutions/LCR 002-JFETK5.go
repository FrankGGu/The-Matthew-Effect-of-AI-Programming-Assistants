func addBinary(a string, b string) string {
    carry := 0
    result := []byte{}
    i, j := len(a)-1, len(b)-1

    for i >= 0 || j >= 0 || carry > 0 {
        sum := carry
        if i >= 0 {
            sum += int(a[i] - '0')
            i--
        }
        if j >= 0 {
            sum += int(b[j] - '0')
            j--
        }
        carry = sum / 2
        result = append(result, byte(sum%2+'0'))
    }

    // Reverse the result
    for left, right := 0, len(result)-1; left < right; left, right = left+1, right-1 {
        result[left], result[right] = result[right], result[left]
    }

    return string(result)
}