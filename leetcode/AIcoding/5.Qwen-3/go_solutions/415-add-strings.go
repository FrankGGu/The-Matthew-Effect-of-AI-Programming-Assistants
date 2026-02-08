package main

func addStrings(num1 string, num2 string) string {
    i := len(num1) - 1
    j := len(num2) - 1
    carry := 0
    result := ""

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
        carry = sum / 10
        result = strconv.Itoa(sum%10) + result
    }

    return result
}