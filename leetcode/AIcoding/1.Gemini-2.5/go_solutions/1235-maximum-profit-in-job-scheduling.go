type Job struct {
	start  int
	end    int
	profit int
}

func jobScheduling(startTime []int, endTime []int, profit []int) int {
	n := len(startTime)