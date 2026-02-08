package main

func minInterval(intervals [][]int, queries []int) []int {
	sort.Slice(intervals, func(i, j int) bool {
		return intervals[i][0] < intervals[j][0]
	})

	queriesWithIndex := make([][2]int, len(queries))
	for i := range queries {
		queriesWithIndex[i] = [2]int{queries[i], i}
	}
	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i][0] < queriesWithIndex[j][0]
	})

	result := make([]int, len(queries))

	var heap []int
	i := 0
	for _, q := range queriesWithIndex {
		queryVal, queryIdx := q[0], q[1]

		for i < len(intervals) && intervals[i][0] <= queryVal {
			heap = append(heap, intervals[i][1]-intervals[i][0]+1)
			i++
		}

		for len(heap) > 0 && heap[0] < 0 {
			heap = heap[1:]
		}

		if len(heap) > 0 {
			result[queryIdx] = heap[0]
		} else {
			result[queryIdx] = -1
		}

		for len(heap) > 0 && heap[0] <= queryVal {
			heap = heap[1:]
		}

		sort.Ints(heap)
	}

	return result
}