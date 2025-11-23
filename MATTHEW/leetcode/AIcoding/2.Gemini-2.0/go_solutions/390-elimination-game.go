func lastRemaining(n int) int {
	head := 1
	step := 1
	remaining := n
	leftToRight := true

	for remaining > 1 {
		if leftToRight || remaining%2 == 1 {
			head += step
		}
		remaining /= 2
		step *= 2
		leftToRight = !leftToRight
	}

	return head
}