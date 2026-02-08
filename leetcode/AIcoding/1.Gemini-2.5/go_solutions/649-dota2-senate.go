func predictPartyVictory(senate string) string {
	n := len(senate)
	radiantQueue := list.New()
	direQueue := list.New()

	// Initialize queues with senator indices
	// The index represents their turn order.
	for