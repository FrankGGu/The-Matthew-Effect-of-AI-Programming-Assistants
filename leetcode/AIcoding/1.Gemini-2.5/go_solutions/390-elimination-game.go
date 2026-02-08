func lastRemaining(n int) int {
    head := 1
    step := 1
    leftToRight := true

    for n > 1 {
        if leftToRight || n%2 == 1 {
            head = head + step
        }
        n = n / 2
        step = step * 2
        leftToRight = !leftToRight
    }

    return head
}