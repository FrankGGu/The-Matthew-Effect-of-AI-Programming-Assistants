import (
	"sort"
)

func maxTasks(tasks []int, workers []int, pills int, strength int) int {
	sort.Ints(tasks)
	sort.Ints(workers)

	l, r := 0, len(tasks)
	ans := 0

	for l <= r {
		mid := l + (r-l)/2
		if possible(tasks, workers, pills, strength, mid) {
			ans = mid
			l = mid + 1
		} else {
			r = mid - 1
		}
	}

	return ans
}

func possible(tasks []int, workers []int, pills int, strength int, k int) bool {
	pillsNeeded := 0
	tempWorkers := make([]int, len(workers))
	copy(tempWorkers, workers)
	sort.Sort(sort.Reverse(sort.IntSlice(tempWorkers)))

	for i := k - 1; i >= 0; i-- {
		if tempWorkers[len(workers)-1-i] >= tasks[i] {
			continue
		}
		if pills > 0 && tempWorkers[len(workers)-1-i]+strength >= tasks[i] {
			pills--
			continue
		}
		return false
	}
	return true
}