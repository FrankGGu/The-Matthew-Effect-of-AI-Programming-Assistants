func countGoodMeals(deliciousness []int) int {
	count := make(map[int]int)
	res := 0
	mod := 1000000007

	for _, d := range deliciousness {
		for i := 0; i < 22; i++ {
			powerOfTwo := 1 << i
			complement := powerOfTwo - d
			res = (res + count[complement]) % mod
		}
		count[d]++
	}

	return res
}