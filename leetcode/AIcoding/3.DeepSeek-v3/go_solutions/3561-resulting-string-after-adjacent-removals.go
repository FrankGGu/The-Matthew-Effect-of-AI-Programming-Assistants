func removeDuplicates(s string, k int) string {
    stack := []rune{}
    count := []int{}

    for _, char := range s {
        if len(stack) > 0 && stack[len(stack)-1] == char {
            count[len(count)-1]++
        } else {
            stack = append(stack, char)
            count = append(count, 1)
        }

        if count[len(count)-1] == k {
            stack = stack[:len(stack)-1]
            count = count[:len(count)-1]
        }
    }

    var result strings.Builder
    for i := 0; i < len(stack); i++ {
        result.WriteString(strings.Repeat(string(stack[i]), count[i]))
    }

    return result.String()
}