package main

func makeGood(s string) string {
    stack := []rune{}
    for _, c := range s {
        if len(stack) > 0 && (abs(int(c)-int(stack[len(stack)-1])) == 32) {
            stack = stack[:len(stack)-1]
        } else {
            stack = append(stack, c)
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