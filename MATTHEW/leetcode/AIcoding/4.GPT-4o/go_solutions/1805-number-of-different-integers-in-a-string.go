package main

import (
	"fmt"
	"regexp"
	"strings"
)

func numDifferentIntegers(word string) int {
	re := regexp.MustCompile("[0-9]+")
	matches := re.FindAllString(word, -1)
	uniqueInts := make(map[string]struct{})

	for _, match := range matches {
		uniqueInts[strings.TrimLeft(match, "0")] = struct{}{}
	}

	return len(uniqueInts)
}

func main() {
	fmt.Println(numDifferentIntegers("a123bc34d8ef34")) // Example usage
}