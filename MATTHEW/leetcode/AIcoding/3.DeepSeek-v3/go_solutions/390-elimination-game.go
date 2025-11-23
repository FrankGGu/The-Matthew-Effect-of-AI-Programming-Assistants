func lastRemaining(n int) int {
    left := true
    remaining := n
    step := 1
    head := 1
    for remaining > 1 {
        if left || remaining%2 == 1 {
            head += step
        }
        remaining /= 2
        step *= 2
        left = !left
    }
    return head
}