type NumberPower struct {
	Value int
	Power int
}

type PowerCalculator struct {
	memo map[int]int
}