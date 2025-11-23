import "sort"

func leastInterval(tasks []byte, n int) int {
	counts := make(map[byte]int)
	for _, task := range tasks {
		counts[task]++
	}

	maxHeap := make([]int, 0)
	for _, count := range counts {
		maxHeap = append(maxHeap, count)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(maxHeap)))

	time := 0
	for len(maxHeap) > 0 {
		temp := make([]int, 0)
		for i := 0; i <= n; i++ {
			if len(maxHeap) == 0 {
				break
			}
			maxHeap[0]--
			if maxHeap[0] > 0 {
				temp = append(temp, maxHeap[0])
			}
			maxHeap = maxHeap[1:]
			time++
		}

		for _, val := range temp {
			maxHeap = append(maxHeap, val)
		}

		sort.Sort(sort.Reverse(sort.IntSlice(maxHeap)))
	}

	return time
}