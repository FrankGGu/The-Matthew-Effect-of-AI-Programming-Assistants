func canVisitAllRooms(rooms [][]int) bool {
    n := len(rooms)
    visited := make([]bool, n)
    visited[0] = true
    queue := []int{0}
    count := 1

    for len(queue) > 0 {
        room := queue[0]
        queue = queue[1:]

        for _, key := range rooms[room] {
            if !visited[key] {
                visited[key] = true
                queue = append(queue, key)
                count++
            }
        }
    }

    return count == n
}