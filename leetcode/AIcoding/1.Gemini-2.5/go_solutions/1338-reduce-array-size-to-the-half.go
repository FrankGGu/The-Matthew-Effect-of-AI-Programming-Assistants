import (
	"sort"
)

func minSetSize(arr []int) int {
	freqMap := make(map[int]int)
	for _, num := range arr {
		freqMap[num]++
	}

	frequencies := make([]int, 0, len(freqMap))
	for _, freq := range freqMap {
		frequencies = append(frequencies, freq)
	}

	sort.Slice(frequencies, func(i, j int) bool {
		return frequencies[i] > frequencies[j]
	})

	targetSize := len(arr) / 2
	currentRemoved := 0
	setCount := 0

	for _, freq := range frequencies {
		currentRemoved += freq
		setCount++
		if currentRemoved >= targetSize {
			break
		}
	}

	return setCount
}