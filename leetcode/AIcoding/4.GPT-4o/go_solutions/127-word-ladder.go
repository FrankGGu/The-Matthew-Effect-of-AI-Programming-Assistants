package main

import (
	"container/list"
	"fmt"
)

func ladderLength(beginWord string, endWord string, wordList []string) int {
	wordSet := make(map[string]struct{})
	for _, word := range wordList {
		wordSet[word] = struct{}{}
	}

	if _, ok := wordSet[endWord]; !ok {
		return 0
	}

	queue := list.New()
	queue.PushBack(beginWord)
	visited := make(map[string]bool)
	visited[beginWord] = true
	step := 1

	for queue.Len() > 0 {
		size := queue.Len()
		for i := 0; i < size; i++ {
			word := queue.Remove(queue.Front()).(string)
			if word == endWord {
				return step
			}
			for j := 0; j < len(word); j++ {
				for c := 'a'; c <= 'z'; c++ {
					newWord := word[:j] + string(c) + word[j+1:]
					if _, found := wordSet[newWord]; found && !visited[newWord] {
						visited[newWord] = true
						queue.PushBack(newWord)
					}
				}
			}
		}
		step++
	}
	return 0
}

func main() {
	fmt.Println(ladderLength("hit", "cog", []string{"hot", "dot", "dog", "lot", "log", "cog"}))
}