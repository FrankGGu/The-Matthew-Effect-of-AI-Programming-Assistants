package main

import (
	"container/list"
)

func findLexSmallestString(s string, a int, b int) string {
	n := len(s)
	minString := s

	q := list.New()
	q.PushBack(s)

	visited := make(map[string]bool)
	visited[s] = true

	for q.Len() > 0 {
		currNode := q.Front()
		q.Remove(currNode)
		curr := currNode.Value.(string)

		if curr < minString {
			minString = curr
		}

		// Operation 1: Add 'a' to all digits at odd indices
		bytes := []byte(curr)
		for i := 1; i < n; i += 2 { // Odd indices (0-indexed)
			bytes[i] = byte((int(bytes[i]-'0') + a) % 10 + '0')
		}
		nextAdd := string(bytes)

		if !visited[nextAdd] {
			visited[nextAdd] = true
			q.PushBack(nextAdd)
		}

		// Operation 2: Rotate the string by 'b' positions
		nextRotate := curr[n-b:] + curr[:n-b]

		if !visited[nextRotate] {
			visited[nextRotate] = true
			q.PushBack(nextRotate)
		}
	}

	return minString
}