func removeAdjacentAlmostEqual(s string) string {
    stack := []rune{}
    for _, ch := range s {
        if len(stack) > 0 && (stack[len(stack)-1] == ch || abs(int(stack[len(stack)-1])-int(ch)) == 1) {
            stack = stack[:len(stack)-1]
        } else {
            stack = append(stack, ch)
        }
    }
    return string(stack)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}