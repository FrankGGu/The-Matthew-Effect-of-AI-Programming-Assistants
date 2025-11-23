import "sort"

func isNStraightHand(hand []int, groupSize int) bool {
	n := len(hand)
	if n%groupSize != 0 {
		return false
	}

	sort.Ints(hand)
	count := make(map[int]int)
	for _, num := range hand {
		count[num]++
	}

	for i := 0; i < n; i++ {
		if count[hand[i]] == 0 {
			continue
		}

		first := hand[i]
		for j := 0; j < groupSize; j++ {
			if count[first+j] == 0 {
				return false
			}
			count[first+j]--
		}
	}

	return true
}