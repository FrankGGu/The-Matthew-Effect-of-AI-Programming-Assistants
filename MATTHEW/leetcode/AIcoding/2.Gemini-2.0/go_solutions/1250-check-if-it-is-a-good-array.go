func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func isGoodArray(nums []int) bool {
	res := 0
	for _, num := range nums {
		res = gcd(res, num)
	}
	return res == 1
}