func canVisitAllRooms(rooms [][]int) bool {
    visited := make([]bool, len(rooms))
    queue := []int{0}
    visited[0] = true

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]

        for _, key := range rooms[current] {
            if !visited[key] {
                visited[key] = true
                queue = append(queue, key)
            }
        }
    }

    for _, v := range visited {
        if !v {
            return false
        }
    }
    return true
}