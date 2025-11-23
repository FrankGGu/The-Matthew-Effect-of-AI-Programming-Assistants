package main

func removeKDigits(num string, k int) string {
    stack := []rune{}
    for _, ch := range num {
        for k > 0 && len(stack) > 0 && stack[len(stack)-1] > ch {
            stack = stack[:len(stack)-1]
            k--
        }
        stack = append(stack, ch)
    }
    // Remove remaining k digits from the end
    for k > 0 {
        stack = stack[:len(stack)-1]
        k--
    }
    // Convert to string and remove leading zeros
    result := string(stack)
    i := 0
    for i < len(result) && result[i] == '0' {
        i++
    }
    if i == len(result) {
        return "0"
    }
    return result[i:]
}