func minimumOperations(start int, target int) int {
    if start == target {
        return 0
    }

    queue := []int{start}
    visited := make(map[int]bool)
    visited[start] = true
    operations := 0

    for len(queue) > 0 {
        operations++
        for size := len(queue); size > 0; size-- {
            current := queue[0]
            queue = queue[1:]

            for _, next := range []int{current + 1, current - 1, current * 2} {
                if next == target {
                    return operations
                }
                if next >= 0 && !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }
        }
    }

    return -1
}