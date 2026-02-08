func findLadders(beginWord string, endWord string, wordList []string) [][]string {
    wordSet := make(map[string]bool)
    for _, word := range wordList {
        wordSet[word] = true
    }
    if !wordSet[endWord] {
        return [][]string{}
    }

    layer := make(map[string][][]string)
    layer[beginWord] = [][]string{{beginWord}}

    for len(layer) > 0 {
        newLayer := make(map[string][][]string)
        for word, paths := range layer {
            if word == endWord {
                return paths
            }
            for i := 0; i < len(word); i++ {
                for c := 'a'; c <= 'z'; c++ {
                    newWord := word[:i] + string(c) + word[i+1:]
                    if wordSet[newWord] {
                        for _, path := range paths {
                            newPath := make([]string, len(path)+1)
                            copy(newPath, path)
                            newPath[len(newPath)-1] = newWord
                            newLayer[newWord] = append(newLayer[newWord], newPath)
                        }
                    }
                }
            }
        }
        for word := range newLayer {
            delete(wordSet, word)
        }
        layer = newLayer
    }

    return [][]string{}
}