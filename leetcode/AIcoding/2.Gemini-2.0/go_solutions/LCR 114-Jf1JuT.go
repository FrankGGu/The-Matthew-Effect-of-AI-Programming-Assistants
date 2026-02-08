func alienOrder(words []string) string {
    adj := make(map[byte][]byte)
    inDegree := make(map[byte]int)

    for _, word := range words {
        for i := 0; i < len(word); i++ {
            inDegree[word[i]] = 0
        }
    }

    for i := 0; i < len(words)-1; i++ {
        word1, word2 := words[i], words[i+1]
        minLen := min(len(word1), len(word2))
        for j := 0; j < minLen; j++ {
            if word1[j] != word2[j] {
                adj[word1[j]] = append(adj[word1[j]], word2[j])
                inDegree[word2[j]]++
                break
            }
            if j == minLen-1 && len(word1) > len(word2) {
                return ""
            }
        }
    }

    queue := []byte{}
    for char, degree := range inDegree {
        if degree == 0 {
            queue = append(queue, char)
        }
    }

    result := []byte{}
    for len(queue) > 0 {
        char := queue[0]
        queue = queue[1:]
        result = append(result, char)

        for _, neighbor := range adj[char] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    if len(result) != len(inDegree) {
        return ""
    }

    return string(result)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}