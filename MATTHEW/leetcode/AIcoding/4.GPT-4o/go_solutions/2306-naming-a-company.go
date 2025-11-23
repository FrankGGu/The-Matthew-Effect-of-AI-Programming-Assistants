package main

import (
	"fmt"
	"sort"
)

func distinctNames(ideas []string) int64 {
	ideaSet := make(map[string]struct{})
	for _, idea := range ideas {
		ideaSet[idea] = struct{}{}
	}

	letters := make(map[byte]map[string]struct{})
	for _, idea := range ideas {
		firstChar := idea[0]
		if letters[firstChar] == nil {
			letters[firstChar] = make(map[string]struct{})
		}
		letters[firstChar][idea[1:]] = struct{}{}
	}

	result := int64(0)
	for firstCharA, suffixesA := range letters {
		for firstCharB, suffixesB := range letters {
			if firstCharA == firstCharB {
				continue
			}
			commonCount := 0
			for suffix := range suffixesA {
				if _, exists := suffixesB[suffix]; exists {
					commonCount++
				}
			}
			result += int64((len(suffixesA) - commonCount) * (len(suffixesB) - commonCount))
		}
	}

	return result
}

func main() {
	ideas := []string{"coffee", "donuts", "time", "toffee"}
	fmt.Println(distinctNames(ideas))
}