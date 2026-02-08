func minimumOperationsToMakeEqual(x int, y int) int {
    if x == y {
        return 0
    }
    if x < y {
        return y - x
    }

    queue := []int{x}
    visited := make(map[int]bool)
    visited[x] = true
    operations := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]

            if current == y {
                return operations
            }

            next := current + 1
            if !visited[next] {
                visited[next] = true
                queue = append(queue, next)
            }

            next = current - 1
            if next >= y && !visited[next] {
                visited[next] = true
                queue = append(queue, next)
            }

            if current % 11 == 0 {
                next = current / 11
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }

            if current % 5 == 0 {
                next = current / 5
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }
        }
        operations++
    }
    return operations
}