import "sort"

func minimumMoney(transactions [][]int) int64 {
	loss := 0
	gain := 0
	for _, t := range transactions {
		if t[0] > t[1] {
			loss += t[0] - t[1]
		}
		if t[0] < t[1] {
			gain = max(gain, t[1])
		}
	}

	sort.Slice(transactions, func(i, j int) bool {
		return transactions[i][0] - transactions[i][1] > transactions[j][0] - transactions[j][1]
	})

	maxCost := 0
	cur := 0
	for _, t := range transactions {
		maxCost = max(maxCost, cur+t[0])
		cur -= max(0, t[0]-t[1])
	}

	return int64(max(maxCost, loss+gain))
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}