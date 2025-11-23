func minimumTeachings(n int, languages [][]int, friendships [][]int) int {
	needTeach := make(map[int]bool)
	for _, friend := range friendships {
		a, b := friend[0]-1, friend[1]-1
		canCommunicate := false
		for _, langA := range languages[a] {
			for _, langB := range languages[b] {
				if langA == langB {
					canCommunicate = true
					break
				}
			}
			if canCommunicate {
				break
			}
		}
		if !canCommunicate {
			needTeach[a] = true
			needTeach[b] = true
		}
	}

	langCount := make(map[int]int)
	for person := range needTeach {
		for _, lang := range languages[person] {
			langCount[lang]++
		}
	}

	maxPeople := 0
	for _, count := range langCount {
		if count > maxPeople {
			maxPeople = count
		}
	}

	return len(needTeach) - maxPeople
}