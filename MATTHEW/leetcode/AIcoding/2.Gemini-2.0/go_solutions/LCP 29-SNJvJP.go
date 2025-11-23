func orchestraLayout(num int, row int, col int) int {
	n := num
	r := row
	c := col
	layer := min(min(r, c), min(n-1-r, n-1-c))

	length := n - 2*layer
	perimeter := 4 * (length - 1)

	ans := layer*4* (n - layer) - 4*layer*layer

	r -= layer
	c -= layer

	if r == 0 {
		ans += c + 1
	} else if c == length-1 {
		ans += length - 1 + r + 1
	} else if r == length-1 {
		ans += 2*length - 2 + (length - 1 - c) + 1
	} else {
		ans += 3*length - 3 + (length - 1 - r) + 1
	}

	return (ans-1)%9 + 1
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}