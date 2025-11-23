func sumGame(num string) bool {
	n := len(num)
	s1 := 0
	s2 := 0
	q1 := 0
	q2 := 0

	for i := 0; i < n/2; i++ {
		if num[i] == '?' {
			q1++
		} else {
			s1 += int(num[i] - '0')
		}
	}

	for i := n / 2; i < n; i++ {
		if num[i] == '?' {
			q2++
		} else {
			s2 += int(num[i] - '0')
		}
	}

	diffS := s1 - s2
	diffQ := q1 - q2

	// If the number of question marks in both halves is the same,
	// Bob can always mirror Alice's moves to keep the difference unchanged.
	// So, Bob wins if initial sums are equal, Alice wins if unequal.
	if diffQ == 0 {
		return diffS != 0 // Alice wins if diffS is not 0
	}

	// If the number of question marks is different, players play optimally.
	// Alice wants to make the final difference non-zero.
	// Bob wants to make the final difference zero.
	// Consider the total change in (sum1 - sum2) from all '?'s.
	// Each '?' in the first half can add 0-9 to (sum1-sum2). Alice wants 9, Bob wants 0.
	// Each '?' in the second half can subtract 0-9 from (sum1-sum2). Alice wants 0, Bob wants 9 (to subtract 9).
	// The game boils down to the difference in sums of digits from '?'s.
	// Let diffQ = q1 - q2.
	// The number of 'excess' question marks is abs(diffQ).
	// These 'excess' question marks are in the half with more '?'s.
	// The total number of turns on these 'excess' '?'s is abs(diffQ).
	// If diffQ > 0 (more '?' in first half):
	//   Alice gets ceil(diffQ/2) turns on these '?'s, Bob gets floor(diffQ/2) turns.
	//   Alice puts 9s, Bob puts 0s. Net effect: 9 * ceil(diffQ/2).
	// If diffQ < 0 (more '?' in second half):
	//   Alice gets ceil(abs(diffQ)/2) turns on these '?'s, Bob gets floor(abs(diffQ)/2) turns.
	//   Alice puts 0s, Bob puts 9s. Net effect: -9 * floor(abs(diffQ)/2).
	//
	// This can be simplified:
	// If diffQ is even: final_diff = diffS + 9 * (diffQ / 2)
	// If diffQ is odd:
	//   If diffQ > 0: final_diff = diffS + 9 * (diffQ/2 + 1) (Alice gets the extra +9)
	//   If diffQ < 0: final_diff = diffS + 9 * (diffQ/2)     (Bob gets the extra -9)
	// Note: Go's integer division `diffQ/2` truncates towards zero.
	// For positive diffQ, `diffQ/2` is floor. `diffQ/2 + 1` is ceil.
	// For negative diffQ, `diffQ/2` is ceil.

	var finalDiff int
	if diffQ%2 == 0 {
		finalDiff = diffS + 9*(diffQ/2)
	} else {
		if diffQ > 0 { // Alice has more '?' in first half, and total '?' is odd
			finalDiff = diffS + 9*(diffQ/2+1)
		} else { // Bob has more '?' in second half, and total '?' is odd
			finalDiff = diffS + 9*(diffQ/2)
		}
	}

	return finalDiff != 0 // Alice wins if finalDiff is not 0
}