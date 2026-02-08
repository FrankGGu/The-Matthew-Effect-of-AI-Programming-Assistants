func minMutation(start string, end string, bank []string) int {
    bankSet := make(map[string]struct{})
    for _, gene := range bank {
        bankSet[gene] = struct{}{}
    }

    if _, found := bankSet[end]; !found {
        return -1
    }

    queue := []string{start}
    visited := make(map[string]bool)
    visited[start] = true
    mutations := 0

    for len(queue) > 0 {
        mutations++
        nextQueue := []string{}

        for _, current := range queue {
            for i := 0; i < len(current); i++ {
                for _, c := range "ACGT" {
                    if byte(c) == current[i] {
                        continue
                    }
                    nextGene := current[:i] + string(c) + current[i+1:]
                    if nextGene == end {
                        return mutations
                    }
                    if _, ok := bankSet[nextGene]; ok && !visited[nextGene] {
                        visited[nextGene] = true
                        nextQueue = append(nextQueue, nextGene)
                    }
                }
            }
        }
        queue = nextQueue
    }
    return -1
}