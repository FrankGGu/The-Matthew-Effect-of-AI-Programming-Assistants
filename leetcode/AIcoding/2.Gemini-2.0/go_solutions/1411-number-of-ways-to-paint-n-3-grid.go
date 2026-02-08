func numOfWays(n int) int {
	mod := 1000000007
	type1 := 6
	type2 := 6
	for i := 1; i < n; i++ {
		nextType1 := (type1*3 + type2*2) % mod
		nextType2 := (type1*2 + type2*2) % mod
		type1 = nextType1
		type2 = nextType2
	}
	return (type1 + type2) % mod
}