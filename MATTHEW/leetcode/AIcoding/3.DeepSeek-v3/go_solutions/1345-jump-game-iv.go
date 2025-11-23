func minJumps(arr []int) int {
    n := len(arr)
    if n == 1 {
        return 0
    }

    valueIndices := make(map[int][]int)
    for i, num := range arr {
        valueIndices[num] = append(valueIndices[num], i)
    }

    visited := make([]bool, n)
    visited[0] = true
    queue := []int{0}
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[i]
            if current == n-1 {
                return steps
            }

            if current-1 >= 0 && !visited[current-1] {
                visited[current-1] = true
                queue = append(queue, current-1)
            }

            if current+1 < n && !visited[current+1] {
                visited[current+1] = true
                queue = append(queue, current+1)
            }

            if indices, exists := valueIndices[arr[current]]; exists {
                for _, idx := range indices {
                    if !visited[idx] {
                        visited[idx] = true
                        queue = append(queue, idx)
                    }
                }
                delete(valueIndices, arr[current])
            }
        }
        queue = queue[size:]
        steps++
    }

    return -1
}