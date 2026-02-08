func alienOrder(words []string) string {
	adj := make(map[rune]map[rune]bool) // Adjacency list: u -> v means u comes before v
	inDegree := make(map[rune]int)      // In-degree of each