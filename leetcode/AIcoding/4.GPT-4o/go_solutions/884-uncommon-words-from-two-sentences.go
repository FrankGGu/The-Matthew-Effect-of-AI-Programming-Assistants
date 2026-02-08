package main

import (
	"strings"
	"fmt"
)

func uncommonFromSentences(A string, B string) []string {
	words := make(map[string]int)
	for _, word := range strings.Split(A, " ") {
		words[word]++
	}
	for _, word := range strings.Split(B, " ") {
		words[word]++
	}
	var result []string
	for word, count := range words {
		if count == 1 {
			result = append(result, word)
		}
	}
	return result
}

func main() {
	fmt.Println(uncommonFromSentences("this apple is sweet", "this apple is sour"))
}