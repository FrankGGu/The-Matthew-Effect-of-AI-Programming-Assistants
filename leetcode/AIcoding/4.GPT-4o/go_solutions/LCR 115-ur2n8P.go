func sequenceReconstruction(org []int, seqs [][]int) bool {
    n := len(org)
    if n == 0 {
        return len(seqs) == 0
    }

    indegree := make([]int, n+1)
    graph := make([][]int, n+1)
    numEdges := 0

    for _, seq := range seqs {
        if len(seq) == 0 {
            continue
        }
        for i := 0; i < len(seq); i++ {
            if seq[i] < 1 || seq[i] > n {
                return false
            }
            if i > 0 {
                graph[seq[i-1]] = append(graph[seq[i-1]], seq[i])
                indegree[seq[i]]++
                numEdges++
            }
        }
    }

    queue := []int{}
    for i := 1; i <= n; i++ {
        if indegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    if len(queue) != 1 {
        return false
    }

    index := 0
    for len(queue) > 0 {
        if len(queue) > 1 {
            return false
        }
        curr := queue[0]
        queue = queue[1:]
        if curr != org[index] {
            return false
        }
        index++
        for _, neighbor := range graph[curr] {
            indegree[neighbor]--
            if indegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    return index == n && numEdges == (n - 1)
}