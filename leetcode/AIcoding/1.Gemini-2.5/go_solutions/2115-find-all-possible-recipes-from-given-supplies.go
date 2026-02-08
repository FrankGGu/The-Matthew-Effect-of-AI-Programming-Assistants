func findAllRecipes(recipes []string, ingredients [][]string, supplies []string) []string {
    // Map string names to unique integer IDs for efficient processing
    nameToID := make(map[string]int)
    idToName := make(map[int]string)
    nextID := 0

    getID := func(name string