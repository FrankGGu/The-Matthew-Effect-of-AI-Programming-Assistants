type StudentScore struct {
	ID    int
	Score int
}

type StudentScores []StudentScore

func (s StudentScores) Len() int {
	return len(s)
}

func (s StudentScores) Less(i, j int) bool {
	// Sort by score in descending order
	if s[i].Score != s[j].Score {
		return s[i].Score > s[j].Score
	}
	// If scores are tied, sort by student ID in ascending order
	return s[i].ID < s[j].ID
}

func (s StudentScores) Swap(i, j int) {
	s[i