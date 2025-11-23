import (
    "container/list"
)

func findLadders(beginWord string, endWord string, wordList []string) [][]string {
    wordSet := make(map[string]struct{})
    for _, word := range wordList {
        wordSet[word] = struct{}{}
    }

    if _, exists := wordSet[endWord]; !exists {
        return [][]string{}
    }

    allCombinations := make(map[string][]string)
    for word := range wordSet {
        for i := 0; i < len(word); i++ {
            for c := 'a'; c <= 'z'; c++ {
                nextWord := word[:i] + string(c) + word[i+1:]
                if nextWord != word {
                    allCombinations[word] = append(allCombinations[word], nextWord)
                }
            }
        }
    }

    layer := map[string][]string{{beginWord}: {beginWord}}
    visited := map[string]bool{beginWord: true}
    found := false

    for len(layer) > 0 && !found {
        newLayer := make(map[string][]string)
        for word, paths := range layer {
            for _, nextWord := range allCombinations[word] {
                if nextWord == endWord {
                    found = true
                    for _, path := range paths {
                        newLayer[nextWord] = append(newLayer[nextWord], path+"->"+nextWord)
                    }
                }
                if _, ok := visited[nextWord]; !ok {
                    visited[nextWord] = true
                    for _, path := range paths {
                        newLayer[nextWord] = append(newLayer[nextWord], path+"->"+nextWord)
                    }
                }
            }
        }
        layer = newLayer
    }

    res := [][]string{}
    for _, paths := range layer {
        for _, path := range paths {
            res = append(res, split(path, "->"))
        }
    }
    return res
}

func split(s, sep string) []string {
    parts := []string{}
    for _, part := range strings.Split(s, sep) {
        parts = append(parts, part)
    }
    return parts
}