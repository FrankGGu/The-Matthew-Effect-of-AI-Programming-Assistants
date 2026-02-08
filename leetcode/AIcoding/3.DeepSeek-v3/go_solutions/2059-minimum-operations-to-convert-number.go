func minimumOperations(nums []int, start int, goal int) int {
    visited := make(map[int]bool)
    queue := []int{start}
    visited[start] = true
    operations := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            if current == goal {
                return operations
            }
            if current < 0 || current > 1000 {
                continue
            }
            for _, num := range nums {
                next := current + num
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
                next = current - num
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
                next = current ^ num
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }
        }
        operations++
    }
    return -1
}