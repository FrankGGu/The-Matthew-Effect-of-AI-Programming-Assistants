func numberOfWeakCharacters(properties [][]int) int {
	// Sort properties:
	// Primary key: attack in descending order (stronger attacks first)
	// Secondary key: defense in ascending order (for same attack, weaker defenses first)
	// This specific sorting order is crucial. When we