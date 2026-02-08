func flowerGame(n int, m int) int64 {
	a := int64(n / 2)
	b := int64(n - n/2)
	c := int64(m / 2)
	d := int64(m - m/2)
	return a*d + b*c
}