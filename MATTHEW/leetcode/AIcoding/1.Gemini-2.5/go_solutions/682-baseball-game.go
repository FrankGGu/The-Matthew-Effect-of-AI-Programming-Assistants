func calPoints(operations []string) int {
	scores := []int{}
	totalScore := 0

	for _, op := range operations {
		switch op {
		case "C":
			// Invalidate the previous score
			lastScore := scores[len(scores)-1]
			totalScore -= lastScore
			scores = scores[:len(scores)-1] // Pop the last score
		case "D":
			// Double the previous score and add to record
			lastScore := scores[len(scores)-1]
			newScore := lastScore * 2
			scores = append(scores, newScore) // Push the new score
			totalScore += newScore
		case "+":
			// Sum of the previous two scores and add to record
			score1 := scores[len(scores)-1]
			score2 := scores[len(scores)-2]
			newScore := score1 + score2
			scores = append(scores, newScore) // Push the new score
			totalScore += newScore
		default:
			// It's an integer, add to record
			num, _ := strconv.Atoi(op) // Convert string to integer
			scores = append(scores, num) // Push the new score
			totalScore += num
		}
	}

	return totalScore
}