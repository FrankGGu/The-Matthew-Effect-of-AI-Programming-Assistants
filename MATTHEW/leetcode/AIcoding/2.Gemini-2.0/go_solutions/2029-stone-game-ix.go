func stoneGameIX(stones []int) bool {
	cnt0, cnt1, cnt2 := 0, 0, 0
	for _, stone := range stones {
		if stone%3 == 0 {
			cnt0++
		} else if stone%3 == 1 {
			cnt1++
		} else {
			cnt2++
		}
	}

	if cnt0%2 == 0 {
		return cnt1 >= 1 && cnt2 >= 1 && abs(cnt1-cnt2) > 2
	} else {
		return cnt1 >= 1 && cnt2 >= 1
	}
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}