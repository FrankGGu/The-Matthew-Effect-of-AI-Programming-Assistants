package main

import (
	"strconv"
)

func getFolderNames(names []string) []string {
	usedNames := make(map[string]bool)
	nextSuffix := make(map[string]int)
	result := make([]string, len(names))

	for i, name := range names {
		currentName := name
		suffixNum := nextSuffix[name] // Default 0 if not present

		for {
			if !usedNames[currentName] { // If currentName is not taken
				break
			}
			// currentName is taken, try the next suffix
			suffixNum++
			currentName = name + "(" + strconv.Itoa(suffixNum) + ")"
		}

		// Found a unique currentName
		result[i] = currentName
		usedNames[currentName] = true
		nextSuffix[name] = suffixNum + 1 // Store the next suffix to try for the original base name
	}

	return result
}