func abbreviateProduct(left int, right int) string {
	// 1. Calculate trailing zeros (X)
	count2 := 0
	count5 := 0
	for i := left; i <=