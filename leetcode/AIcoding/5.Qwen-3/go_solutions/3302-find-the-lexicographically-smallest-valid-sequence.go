package main

func findLexicographicallySmallestValidSequence(n int, startIndex int, goalIndex int, words []string) []int {
    wordLen := len(words[0])
    adj := make(map[int][]int)
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            if i != j && areAdjacent(words[i], words[j]) {
                adj[i] = append(adj[i], j)
            }
        }
    }

    parent := make([]int, n)
    visited := make([]bool, n)
    queue := []int{startIndex}
    visited[startIndex] = true

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        if node == goalIndex {
            break
        }
        for _, neighbor := range adj[node] {
            if !visited[neighbor] {
                visited[neighbor] = true
                parent[neighbor] = node
                queue = append(queue, neighbor)
            }
        }
    }

    result := []int{goalIndex}
    current := goalIndex
    for current != startIndex {
        current = parent[current]
        result = append(result, current)
    }

    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }

    return result
}

func areAdjacent(a, b string) bool {
    diff := 0
    for i := 0; i < len(a); i++ {
        if a[i] != b[i] {
            diff++
            if diff > 1 {
                return false
            }
        }
    }
    return diff == 1
}