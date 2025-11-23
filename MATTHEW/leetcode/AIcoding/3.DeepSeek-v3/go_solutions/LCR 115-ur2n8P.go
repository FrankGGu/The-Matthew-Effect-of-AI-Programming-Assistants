func sequenceReconstruction(nums []int, sequences [][]int) bool {
    n := len(nums)
    graph := make(map[int]map[int]bool)
    inDegree := make(map[int]int)

    for _, seq := range sequences {
        for i := 0; i < len(seq)-1; i++ {
            u, v := seq[i], seq[i+1]
            if _, ok := graph[u]; !ok {
                graph[u] = make(map[int]bool)
            }
            if !graph[u][v] {
                graph[u][v] = true
                inDegree[v]++
            }
        }
    }

    queue := []int{}
    for i := 1; i <= n; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    index := 0
    for len(queue) == 1 {
        u := queue[0]
        queue = queue[1:]

        if index >= n || nums[index] != u {
            return false
        }
        index++

        for v := range graph[u] {
            inDegree[v]--
            if inDegree[v] == 0 {
                queue = append(queue, v)
            }
        }
    }

    return index == n
}