func isValidSerialization(preorder string) bool {
	if preorder == "" {
		return false
	}

	nodes := strings.Split(preorder, ",")

	// balance represents the number of available "slots" or "degree" for children.
	// Initially, we start with 1 slot,