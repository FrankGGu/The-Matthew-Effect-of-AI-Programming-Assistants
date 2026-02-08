import "sort"

type TopVotedCandidate struct {
	times             []int
	leadingCandidates []int
}

func Constructor(persons []int, times []int) TopVotedCandidate {
	n := len(persons)
	leadingCandidates := make([]int, n)

	counts := make(map[int]int)