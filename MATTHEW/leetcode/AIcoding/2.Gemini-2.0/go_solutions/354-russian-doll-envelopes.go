import "sort"

func maxEnvelopes(envelopes [][]int) int {
	sort.Slice(envelopes, func(i, j int) bool {
		if envelopes[i][0] == envelopes[j][0] {
			return envelopes[i][1] > envelopes[j][1]
		}
		return envelopes[i][0] < envelopes[j][0]
	})

	heights := make([]int, len(envelopes))
	for i := range envelopes {
		heights[i] = envelopes[i][1]
	}

	tails := []int{}
	for _, h := range heights {
		i, j := 0, len(tails)
		for i < j {
			mid := (i + j) / 2
			if tails[mid] < h {
				i = mid + 1
			} else {
				j = mid
			}
		}
		if i == len(tails) {
			tails = append(tails, h)
		} else {
			tails[i] = h
		}
	}

	return len(tails)
}