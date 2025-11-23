import (
	"sort"
)

func canReorderDoubled(arr []int) bool {
	freqMap := make(map[int]int)
	for _, num := range arr {
		freqMap[num]++
	}

	keys := make([]int, 0, len(freqMap))
	for k := range freqMap {
		keys = append(keys, k)
	}

	sort.Slice(keys, func(i, j int) bool {
		return abs(keys[i]) < abs(keys[j])
	})

	for _, x := range keys {
		if freqMap[x] == 0 {
			continue
		}

		if x == 0 {
			if freqMap[0]%2 != 0 {
				return false
			}
			freqMap[0] = 0
			continue
		}

		target := 2 * x
		if freqMap[target] < freqMap[x] {
			return false
		}
		freqMap[target] -= freqMap[x]
		freqMap[x] = 0
	}

	return true
}

func abs(a int) int {
	if a < 0 {
		return -a
	}
	return a
}