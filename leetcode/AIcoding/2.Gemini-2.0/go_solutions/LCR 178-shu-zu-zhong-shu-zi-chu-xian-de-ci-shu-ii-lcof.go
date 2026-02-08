import "sort"

func trainingPlan(tasks []int) []int {
	sort.Ints(tasks)
	n := len(tasks)
	res := make([]int, n)
	for i := 0; i < n; i++ {
		res[i] = tasks[n-1-i]
	}
	return res
}