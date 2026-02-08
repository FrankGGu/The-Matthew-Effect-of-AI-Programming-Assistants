type Job struct {
	difficulty int
	profit     int
}

func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
	n := len(difficulty)
	jobs := make([]Job, n)
	for