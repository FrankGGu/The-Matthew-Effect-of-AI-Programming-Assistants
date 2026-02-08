func isItPossible(word1 string, word2 string) bool {
	cnt1 := make(map[rune]int)
	cnt2 := make(map[rune]int)
	for _, c := range word1 {
		cnt1[c]++
	}
	for _, c := range word2 {
		cnt2[c]++
	}

	distinct1 := len(cnt1)
	distinct2 := len(cnt2)

	for c1 := range cnt1 {
		for c2 := range cnt2 {
			newCnt1 := make(map[rune]int)
			newCnt2 := make(map[rune]int)

			for c, count := range cnt1 {
				if c != c1 {
					newCnt1[c] = count
				} else {
					if count > 1 {
						newCnt1[c] = count - 1
					}
				}
			}
			newCnt1[c2]++

			for c, count := range cnt2 {
				if c != c2 {
					newCnt2[c] = count
				} else {
					if count > 1 {
						newCnt2[c] = count - 1
					}
				}
			}
			newCnt2[c1]++

			d1 := 0
			for range newCnt1 {
				d1++
			}
			d2 := 0
			for range newCnt2 {
				d2++
			}

			if d1 == d2 {
				return true
			}
		}
	}
	return false
}