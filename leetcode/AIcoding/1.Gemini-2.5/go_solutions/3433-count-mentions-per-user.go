func countMentionsPerUser(messages []string) map[string]int {
	mentionsCount := make(map[string]int)

	// Regular expression to find mentions.
	// It looks for '@' followed by a capturing group `(...)` that matches one or more
	// alphanumeric characters (a-z, A-Z, 0-9) or underscores (_).
	// This ensures that punctuation immediately following a mention (e.g., "@user.") is not included in the username.
	re := regexp.MustCompile(`@([a-zA-Z0-9_]+)`)

	for _, message := range messages {
		// FindAllStringSubmatch returns a slice of slices of strings.
		// Each inner slice represents one match.
		// The first element of the inner slice ([0]) is the full match (e.g., "@username").
		// Subsequent elements ([1], [2], etc.) are the captured groups.
		// We are interested in the first capturing group ([1]) which is the username itself.
		// The -1 argument means to find all non-overlapping matches.
		matches := re.FindAllStringSubmatch(message, -1)

		for _, match := range