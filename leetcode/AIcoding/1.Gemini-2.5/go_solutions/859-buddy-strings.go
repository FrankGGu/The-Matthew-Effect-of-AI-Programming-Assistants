func buddyStrings(s string, goal string) bool {
	if len(s) != len(goal) {
		return false
	}

	if s == goal {
		// If s and goal are identical, we need to check if s has at least one duplicate character.
		// If it does, we can swap the two identical characters