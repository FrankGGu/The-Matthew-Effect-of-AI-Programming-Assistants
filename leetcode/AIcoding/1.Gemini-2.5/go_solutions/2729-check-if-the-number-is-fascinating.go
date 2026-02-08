func isFascinating(n int) bool {
	num2 := n * 2
	num3 := n * 3

	s := fmt.Sprintf("%d%d%d", n, num2, num3)

	if len(s) != 9 {