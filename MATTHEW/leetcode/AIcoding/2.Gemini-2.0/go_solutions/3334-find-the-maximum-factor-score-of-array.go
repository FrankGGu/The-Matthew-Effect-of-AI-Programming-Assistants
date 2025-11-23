func maxFactorScore(nums []int) int {
	maxScore := 0
	for _, num := range nums {
		score := 1
		for i := 2; i*i <= num; i++ {
			if num%i == 0 {
				score++
				if i*i != num {
					score++
				}
			}
		}
		if num > 1 {
			if score == 1 {
				for i := 2; i < num; i++ {
					if num%i == 0 {
						score++
						break
					}
				}
			}
		}
		if score > maxScore {
			maxScore = score
		}
	}
	return maxScore
}