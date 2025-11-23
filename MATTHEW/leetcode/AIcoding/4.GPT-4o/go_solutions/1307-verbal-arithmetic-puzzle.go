package main

import (
	"fmt"
	"math"
)

func isSolvable(words []string, result string) bool {
	letterMap := make(map[rune]int)
	used := make([]bool, 10)
	var letters []rune

	for _, word := range words {
		for _, char := range word {
			if _, exists := letterMap[char]; !exists {
				letterMap[char] = -1
				letters = append(letters, char)
			}
		}
	}
	for _, char := range result {
		if _, exists := letterMap[char]; !exists {
			letterMap[char] = -1
			letters = append(letters, char)
		}
	}

	if len(letters) > 10 {
		return false
	}

	return backtrack(letters, letterMap, used, 0, words, result)
}

func backtrack(letters []rune, letterMap map[rune]int, used []bool, index int, words []string, result string) bool {
	if index == len(letters) {
		return checkSum(words, result, letterMap)
	}

	for num := 0; num < 10; num++ {
		if used[num] {
			continue
		}
		letterMap[letters[index]] = num
		used[num] = true
		if backtrack(letters, letterMap, used, index+1, words, result) {
			return true
		}
		letterMap[letters[index]] = -1
		used[num] = false
	}
	return false
}

func checkSum(words []string, result string, letterMap map[rune]int) bool {
	wordSum := 0
	for _, word := range words {
		wordSum += getValue(word, letterMap)
	}
	resultValue := getValue(result, letterMap)
	return wordSum == resultValue
}

func getValue(word string, letterMap map[rune]int) int {
	value := 0
	for _, char := range word {
		value = value*10 + letterMap[char]
	}
	return value
}

func isSolvable(words []string, result string) bool {
	return isSolvable(words, result)
}

func main() {
	words := []string{"send", "more"}
	result := "money"
	fmt.Println(isSolvable(words, result))
}