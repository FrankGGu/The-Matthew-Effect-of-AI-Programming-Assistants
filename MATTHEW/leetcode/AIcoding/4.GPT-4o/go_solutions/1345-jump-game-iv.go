func minJumps(arr []int) int {
    n := len(arr)
    if n <= 1 {
        return 0
    }

    graph := make(map[int][]int)
    for i, num := range arr {
        graph[num] = append(graph[num], i)
    }

    visited := make([]bool, n)
    visited[0] = true
    queue := []int{0}
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            index := queue[0]
            queue = queue[1:]
            if index == n-1 {
                return steps
            }
            nextIndices := []int{index - 1, index + 1}
            nextIndices = append(nextIndices, graph[arr[index]]...)
            graph[arr[index]] = nil

            for _, nextIndex := range nextIndices {
                if nextIndex >= 0 && nextIndex < n && !visited[nextIndex] {
                    visited[nextIndex] = true
                    queue = append(queue, nextIndex)
                }
            }
        }
        steps++
    }

    return -1
}