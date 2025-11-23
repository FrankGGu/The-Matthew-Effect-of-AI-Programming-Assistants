var memo [11][2][2][2][2]int

func solve(s string, d int) int {
	for i := 0; i < 11; i++ {
		for j := 0; j < 2; j++ {
			for k := 0