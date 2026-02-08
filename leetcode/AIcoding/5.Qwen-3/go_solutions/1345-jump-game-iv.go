package main

func minJump(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }
    visited := make([]bool, n)
    queue := []int{0}
    visited[0] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]
            if current == n-1 {
                return steps
            }
            for j := current + 1; j <= current+nums[current] && j < n; j++ {
                if !visited[j] {
                    visited[j] = true
                    queue = append(queue, j)
                }
            }
            if current+nums[current] >= n-1 {
                return steps + 1
            }
        }
        steps++
    }
    return -1
}