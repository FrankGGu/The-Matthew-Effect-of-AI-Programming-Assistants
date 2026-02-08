func passThePillow(n int, time int) int {
	round := time / (n - 1)
	rem := time % (n - 1)

	if round%2 == 0 {
		return rem + 1
	} else {
		return n - rem
	}
}