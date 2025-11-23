import "sort"

func maximumMatching(players []int, trainers []int) int {
	sort.Ints(players)
	sort.Ints(trainers)

	p := 0 // Pointer for players array
	t := 0 // Pointer for trainers array
	matches := 0

	for p < len(players) && t < len(trainers) {
		if players[p] <= trainers[t] {
			// If the current player's skill is less than or equal to the current trainer's capacity,
			// we can make a match. We increment the match count and move to the next player
			// and next trainer. This greedy choice is optimal because using this trainer for
			//