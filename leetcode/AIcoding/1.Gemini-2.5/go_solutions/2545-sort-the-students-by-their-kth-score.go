type StudentScores [][]int
type KthScoreSorter struct {
	scores StudentScores
	k      int
}

func (s KthScoreSorter) Len() int {
	return len(s.scores)
}

func (s KthScoreSorter) Swap(i, j int) {
	s.scores[i], s.scores[j] = s.scores[j], s.scores[i]
}

func (s KthScoreSorter) Less(i, j int) bool {
	// Sort in descending order based on the k-th score
	return s.scores[i][s.k] > s.scores[j][s.k]
}

func sortTheStudents(scores [][]int, k int) [][]int {
	sorter := KthScoreSorter{
		scores: scores,
		k:      k,
	}
	sort.Sort(sorter)
	return sorter.scores
}