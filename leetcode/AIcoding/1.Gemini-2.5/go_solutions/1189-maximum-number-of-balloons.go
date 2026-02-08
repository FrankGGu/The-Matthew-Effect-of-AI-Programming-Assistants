func maxNumberOfBalloons(text string) int {
	counts := [26]int{}
	for _, char := range text {
		counts[char-'a']++
	}

	bCount := counts['b'-'a']
	aCount := counts['a'-'a']
	lCount := counts['l'-'a'] / 2
	oCount := counts['o'-'a'] / 2
	nCount := counts['n'-'a']

	minBalloons := bCount
	if aCount < minBalloons {
		minBalloons = aCount
	}
	if lCount < minBalloons {
		minBalloons = lCount
	}
	if oCount < minBalloons {
		minBalloons = oCount
	}
	if nCount < minBalloons {
		minBalloons = nCount
	}

	return minBalloons
}