import "sort"

func splitPainting(segments [][]int) [][]int64 {
	points := make(map[int]int64)
	for _, segment := range segments {
		points[segment[0]] = 0
		points[segment[1]] = 0
	}

	for _, segment := range segments {
		for i := segment[0]; i < segment[1]; i++ {
			points[i] += int64(segment[2])
		}
	}

	keys := make([]int, 0, len(points))
	for k := range points {
		keys = append(keys, k)
	}
	sort.Ints(keys)

	result := make([][]int64, 0)
	for i := 0; i < len(keys)-1; i++ {
		if points[keys[i]] > 0 {
			result = append(result, []int64{int64(keys[i]), int64(keys[i+1]), points[keys[i]]})
		}
	}

	return result
}