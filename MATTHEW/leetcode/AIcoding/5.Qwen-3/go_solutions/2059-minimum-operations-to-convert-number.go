package main

func minimumOperations(nums []int, start int, target int) int {
    visited := make(map[int]bool)
    queue := []int{start}
    visited[start] = true

    for len(queue) > 0 {
        for _, num := range queue {
            if num == target {
                return 0
            }
            for _, x := range nums {
                next := num ^ x
                if !visited[next] {
                    visited[next] = true
                    queue = append(queue, next)
                }
            }
        }
        queue = queue[1:]
    }

    return -1
}