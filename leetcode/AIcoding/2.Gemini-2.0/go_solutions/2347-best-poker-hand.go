func bestHand(ranks []int, suits []byte) string {
	sameSuit := true
	for i := 1; i < 5; i++ {
		if suits[i] != suits[0] {
			sameSuit = false
			break
		}
	}
	if sameSuit {
		return "Flush"
	}

	rankCounts := make(map[int]int)
	for _, rank := range ranks {
		rankCounts[rank]++
	}

	maxCount := 0
	for _, count := range rankCounts {
		if count > maxCount {
			maxCount = count
		}
	}

	if maxCount >= 3 {
		return "Three of a Kind"
	} else if maxCount == 2 {
		return "Pair"
	} else {
		return "High Card"
	}
}