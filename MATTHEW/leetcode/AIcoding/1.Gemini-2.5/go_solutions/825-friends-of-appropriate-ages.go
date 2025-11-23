func numFriendRequests(ages []int) int {
	counts := make([]int, 121) // Ages are 1 to 120
	for _, age := range ages {
		counts[age]++
	}

	totalRequests := 0
	for ageA := 1; ageA <= 120; ageA++ {
		if counts[ageA] == 0 {
			continue
		}
		for ageB := 1; ageB <= 120; ageB++ {
			if counts[ageB] == 0 {
				continue
			}

			// Conditions for A to send a request to B:
			// 1. age[B] > 0.5 * age[A] + 7
			// 2. age[B] <= age[A]
			// 3. !(age[B] > 100 && age[A] < 100)
			// The third condition is implicitly satisfied if the first two are met.
			// If ageA < 100, then ageB <= ageA < 100, so ageB > 100 is false.
			// If ageA >= 100, then ageA < 100 is false.
			// In both cases, (ageB > 100 && ageA < 100) is false, so its negation is true.

			if float64(ageB) > 0.5*float64(ageA)+7 && ageB <= ageA {
				if ageA == ageB {
					// A person does not send a request to themselves.
					// If there are N people of ageA, they can send requests to N-1 other people of ageA.
					totalRequests += counts[ageA] * (counts[ageA] - 1)
				} else {
					totalRequests += counts[ageA] * counts[ageB]
				}
			}
		}
	}

	return totalRequests
}