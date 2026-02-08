func canReach(arr []int, start int) bool {
    n := len(arr)
    visited := make([]bool, n)
    queue := []int{start}
    visited[start] = true

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        if arr[current] == 0 {
            return true
        }
        left := current - arr[current]
        if left >= 0 && !visited[left] {
            visited[left] = true
            queue = append(queue, left)
        }
        right := current + arr[current]
        if right < n && !visited[right] {
            visited[right] = true
            queue = append(queue, right)
        }
    }
    return false
}