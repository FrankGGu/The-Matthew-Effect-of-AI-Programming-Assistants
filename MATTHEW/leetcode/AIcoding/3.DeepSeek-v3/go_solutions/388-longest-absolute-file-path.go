func lengthLongestPath(input string) int {
    maxLen := 0
    stack := []int{0}

    for _, line := range strings.Split(input, "\n") {
        level := strings.Count(line, "\t")
        for len(stack) > level + 1 {
            stack = stack[:len(stack)-1]
        }
        length := stack[len(stack)-1] + len(line) - level + 1
        stack = append(stack, length)
        if strings.Contains(line, ".") {
            if length - 1 > maxLen {
                maxLen = length - 1
            }
        }
    }
    return maxLen
}