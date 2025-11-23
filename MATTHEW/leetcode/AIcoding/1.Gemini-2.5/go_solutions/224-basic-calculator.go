func calculate(s string) int {
	stack := make([]struct {
		res  int
		sign int
	}, 0)

	result := 0
	sign := 1 // 1 for positive, -1 for negative

	for i :=