func lastRemaining(n int) int {
    leftToRight := true
    remaining := n
    head := 1

    for remaining > 1 {
        if leftToRight || remaining%2 == 1 {
            head += 1
        }
        remaining /= 2
        leftToRight = !leftToRight
    }

    return head
}