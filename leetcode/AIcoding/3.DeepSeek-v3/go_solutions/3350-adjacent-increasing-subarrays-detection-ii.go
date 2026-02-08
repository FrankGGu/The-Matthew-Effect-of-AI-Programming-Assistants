func canReach(nums []int, start int) bool {
    n := len(nums)
    visited := make([]bool, n)
    queue := []int{start}
    visited[start] = true

    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        if nums[current] == 0 {
            return true
        }
        left := current - nums[current]
        if left >= 0 && !visited[left] {
            visited[left] = true
            queue = append(queue, left)
        }
        right := current + nums[current]
        if right < n && !visited[right] {
            visited[right] = true
            queue = append(queue, right)
        }
    }
    return false
}