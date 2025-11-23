func minMutation(start string, end string, bank []string) int {
    bankSet := make(map[string]bool)
    for _, s := range bank {
        bankSet[s] = true
    }
    if !bankSet[end] {
        return -1
    }

    queue := []string{start}
    visited := make(map[string]bool)
    visited[start] = true
    mutations := 0
    genes := []byte{'A', 'C', 'G', 'T'}

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            if current == end {
                return mutations
            }
            for j := 0; j < len(current); j++ {
                for _, g := range genes {
                    if current[j] == g {
                        continue
                    }
                    newGene := current[:j] + string(g) + current[j+1:]
                    if bankSet[newGene] && !visited[newGene] {
                        visited[newGene] = true
                        queue = append(queue, newGene)
                    }
                }
            }
        }
        mutations++
    }
    return -1
}