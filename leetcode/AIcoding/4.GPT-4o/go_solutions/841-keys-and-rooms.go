func canVisitAllRooms(rooms [][]int) bool {
    visited := make([]bool, len(rooms))
    stack := []int{0}
    visited[0] = true
    count := 1

    for len(stack) > 0 {
        room := stack[len(stack)-1]
        stack = stack[:len(stack)-1]

        for _, key := range rooms[room] {
            if !visited[key] {
                visited[key] = true
                stack = append(stack, key)
                count++
            }
        }
    }

    return count == len(rooms)
}