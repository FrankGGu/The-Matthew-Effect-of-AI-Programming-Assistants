package main

import (
	"sort"
	"strings"
)

func numSpecialEquivGroups(words []string) int {
	uniqueKeys := make(map[string]struct{})

	for _, s := range words {
		evenChars := make([]byte, 0, len(s)/2+1)
		oddChars := make([]byte, 0, len(s)/2+1)

		for i, char := range s {
			if i%2 == 0 {
				evenChars = append(evenChars, byte(char))
			} else {
				oddChars = append(oddChars, byte(char))
			}
		}

		sort.Slice(evenChars, func(i, j int) bool {
			return evenChars[i] < evenChars[j]
		})
		sort.Slice(oddChars, func(i, j int) bool {
			return oddChars[i] < oddChars[j]
		})

		key := string(evenChars) + "#" + string(oddChars)
		uniqueKeys[key] = struct{}{}
	}

	return len(uniqueKeys)
}