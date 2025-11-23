import "sort"

func maxRunTime(n int, batteries []int) int64 {
	sort.Ints(batteries)
	sum := 0
	for _, b := range batteries {
		sum += b
	}

	for batteries[len(batteries)-1] > sum/n {
		sum -= batteries[len(batteries)-1]
		batteries = batteries[:len(batteries)-1]
		n--
	}

	return int64(sum / n)
}