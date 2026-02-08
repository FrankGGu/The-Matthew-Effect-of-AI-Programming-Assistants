func alienOrder(words []string) string {
    graph := make(map[byte]map[byte]bool)
    inDegree := make(map[byte]int)

    for _, word := range words {
        for i := 0; i < len(word); i++ {
            c := word[i]
            if _, ok := inDegree[c]; !ok {
                inDegree[c] = 0
            }
        }
    }

    for i := 0; i < len(words)-1; i++ {
        word1 := words[i]
        word2 := words[i+1]
        if len(word1) > len(word2) && word1[:len(word2)] == word2 {
            return ""
        }
        for j := 0; j < len(word1) && j < len(word2); j++ {
            if word1[j] != word2[j] {
                u := word1[j]
                v := word2[j]
                if _, ok := graph[u]; !ok {
                    graph[u] = make(map[byte]bool)
                }
                if !graph[u][v] {
                    graph[u][v] = true
                    inDegree[v]++
                }
                break
            }
        }
    }

    queue := make([]byte, 0)
    for c, degree := range inDegree {
        if degree == 0 {
            queue = append(queue, c)
        }
    }

    var result []byte
    for len(queue) > 0 {
        u := queue[0]
        queue = queue[1:]
        result = append(result, u)
        for v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    if len(result) != len(inDegree) {
        return ""
    }
    return string(result)
}