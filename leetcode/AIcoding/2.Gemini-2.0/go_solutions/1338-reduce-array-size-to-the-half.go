import "sort"

func minSetSize(arr []int) int {
	count := make(map[int]int)
	for _, num := range arr {
		count[num]++
	}

	freq := make([]int, 0, len(count))
	for _, c := range count {
		freq = append(freq, c)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(freq)))

	n := len(arr)
	removed := 0
	setSize := 0
	for _, f := range freq {
		removed += f
		setSize++
		if removed >= n/2 {
			break
		}
	}

	return setSize
}