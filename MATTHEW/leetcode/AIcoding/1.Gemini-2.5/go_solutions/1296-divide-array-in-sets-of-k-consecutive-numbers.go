import (
	"sort"
)

func isNStraightHand(hand []int, k int) bool {
	n := len(hand)
	if n%k != 0 {
		return false
	}
	if k == 1 {
		return true
	}

	freq := make(map[int]int)
	for _, num := range hand {
		freq[num]++
	}

	distinctNums := make([]int, 0, len(freq))
	for num := range freq {
		distinctNums = append(distinctNums, num)
	}
	sort.Ints(distinctNums)

	for _, num := range distinctNums {
		if freq[num] == 0 {
			continue
		}

		count := freq[num]
		for i := 0; i < k; i++ {
			currentNum := num + i
			if freq[currentNum] < count {
				return false
			}
			freq[currentNum] -= count
		}
	}

	return true
}