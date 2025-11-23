package main

func checkout(queue []int, n int) int {
    for i := 0; i < n; i++ {
        for j := 0; j < len(queue); j++ {
            if queue[j] == 0 {
                queue = append(queue[:j], queue[j+1:]...)
                break
            } else {
                queue[j]--
            }
        }
    }
    return len(queue)
}