package main

import (
	"math"
)

func findLadders(beginWord string, endWord string, wordList []string) [][]string {
	wordMap := make(map[string]bool)
	for _, word := range wordList {
		wordMap[word] = true
	}

	if !wordMap[endWord] {
		return [][]string{}
	}

	// Handle beginWord == endWord case: The shortest path is just the word itself.
	if beginWord == endWord {
		return [][]string{{beginWord}}
	}

	// Add beginWord to wordMap if not present, as it's a valid starting point
	// and can be part of the transformation sequence.
	wordMap[beginWord] = true

	dist := make(map[string]int)
	for k := range wordMap {
		dist[k] = math.MaxInt32 // Initialize all words to "unvisited" (max distance)
	}

	parents := make(map[string][]string) // parents[childWord] stores all parentWord(s) that lead to childWord in a shortest path

	q := []string{beginWord}
	dist[beginWord] = 0
	foundEnd := false

	// BFS to find shortest distance to all reachable words and build the parents map
	for len(q) > 0 {
		levelSize := len(q)
		nextLevelWords := []string{}
		wordsVisitedThisLevel := make(map[string]bool) // To prevent adding the same word multiple times to nextLevelWords in one BFS level

		// If endWord was found in the previous level, we have identified all shortest paths
		// leading to it. We can stop BFS as any further levels would be longer paths.
		if foundEnd {
			break
		}

		for i := 0; i < levelSize; i++ {
			currWord := q[i]
			currDist := dist[currWord]

			chars := []byte(currWord)
			for j := 0; j < len(chars); j++ {
				originalChar := chars[j]
				for c := 'a'; c <= 'z'; c++ {
					if byte(c) == originalChar {
						continue
					}
					chars[j] = byte(c)
					nextWord := string(chars)

					if wordMap[nextWord] {
						// Case 1: nextWord has not been visited yet (or visited with a longer path, which BFS prevents)
						if dist[nextWord] == math.MaxInt32 {
							dist[nextWord] = currDist + 1
							parents[nextWord] = append(parents[nextWord], currWord)
							if !wordsVisitedThisLevel[nextWord] { // Add to next level queue only once per level
								nextLevelWords = append(nextLevelWords, nextWord)
								wordsVisitedThisLevel[nextWord] = true
							}
							if nextWord == endWord {
								foundEnd = true
							}
						} else if dist[nextWord] == currDist+1 { // Case 2: nextWord has been visited, and we found another shortest path to it
							parents[nextWord] = append(parents[nextWord], currWord)
						}
					}
				}
				chars[j] = originalChar // Backtrack char change
			}
		}
		q = nextLevelWords
	}

	// If endWord was not found during BFS, no path exists
	if !foundEnd {
		return [][]string{}
	}

	var result [][]string
	currentPath := []string{}

	// DFS to reconstruct all shortest paths from endWord back to beginWord
	var dfs func(word string)
	dfs = func(word string) {
		currentPath = append(currentPath, word)

		if word == beginWord {
			// A complete path from beginWord to endWord is found.
			// Copy and reverse it, then add to results.
			pathCopy := make([]string, len(currentPath))
			copy(pathCopy, currentPath)
			for i, j := 0, len(pathCopy)-1; i < j; i, j = i+1, j-1 {
				pathCopy[i], pathCopy[j] = pathCopy[j], pathCopy[i]
			}
			result = append(result, pathCopy)
		} else {
			// Explore all parent words that lead to the current word in a shortest path
			for _, parentWord := range parents[word] {
				dfs(parentWord)
			}
		}
		currentPath = currentPath[:len(currentPath)-1] // Backtrack: remove current word for other path explorations
	}

	dfs(endWord)
	return result
}