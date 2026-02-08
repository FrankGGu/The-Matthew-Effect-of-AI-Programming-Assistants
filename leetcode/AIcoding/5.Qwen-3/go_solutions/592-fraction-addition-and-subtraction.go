package main

func addStrings(num1 string, num2 string) string {
    i, j := len(num1)-1, len(num2)-1
    carry := 0
    result := make([]byte, 0, max(len(num1), len(num2))+1)

    for i >= 0 || j >= 0 || carry > 0 {
        digit1 := 0
        if i >= 0 {
            digit1 = int(num1[i] - '0')
            i--
        }

        digit2 := 0
        if j >= 0 {
            digit2 = int(num2[j] - '0')
            j--
        }

        sum := digit1 + digit2 + carry
        carry = sum / 10
        result = append(result, byte('0'+sum%10))
    }

    // Reverse the result
    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }

    return string(result)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}