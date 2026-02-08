func removeSubfolders(folder []string) []string {
	// Sort the folders lexicographically.
	// This ensures that a parent folder always comes before its sub-folders.
	sort.Strings(folder)

	if len(folder) == 0