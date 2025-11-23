package main

func minMutation(startGene string, endGene string, bank []string) int {
    fromTo := map[byte][]byte{
        'A': {'C', 'G', 'T'},
        'C': {'A', 'G', 'T'},
        'G': {'A', 'C', 'T'},
        'T': {'A', 'C', 'G'},
    }

    bankSet := make(map[string]bool)
    for _, gene := range bank {
        bankSet[gene] = true
    }

    queue := []string{startGene}
    visited := make(map[string]bool)
    visited[startGene] = true
    steps := 0

    for len(queue) > 0 {
        for _, gene := range queue {
            if gene == endGene {
                return steps
            }
            for i := 0; i < len(gene); i++ {
                for _, nextChar := range fromTo[gene[i]] {
                    nextGene := gene[:i] + string(nextChar) + gene[i+1:]
                    if !visited[nextGene] && bankSet[nextGene] {
                        visited[nextGene] = true
                        queue = append(queue, nextGene)
                    }
                }
            }
        }
        queue = queue[1:]
        steps++
    }

    return -1
}