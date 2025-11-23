import (
	"sort"
)

func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
	n := len(difficulty)
	jobs := make([][2]int, n)
	for i := 0; i < n; i++ {
		jobs[i] = [2]int{difficulty[i], profit[i]}
	}
	sort.Slice(jobs, func(i, j int) bool {
		return jobs[i][0] < jobs[j][0]
	})
	sort.Ints(worker)

	maxProfit := 0
	total := 0
	i := 0
	best := 0
	for _, ability := range worker {
		for i < n && ability >= jobs[i][0] {
			if jobs[i][1] > best {
				best = jobs[i][1]
			}
			i++
		}
		total += best
	}
	return total
}