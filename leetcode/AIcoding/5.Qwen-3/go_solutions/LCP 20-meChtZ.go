package main

func numBusesToDestination(buses [][]int, target int, startAt int, skipBus int) int {
    visited := make(map[int]bool)
    queue := []int{startAt}
    visited[startAt] = true
    steps := 0

    for len(queue) > 0 {
        size := len(queue)
        for i := 0; i < size; i++ {
            current := queue[0]
            queue = queue[1:]

            if current == target {
                return steps
            }

            for busIdx, bus := range buses {
                if visited[busIdx] || busIdx == skipBus {
                    continue
                }

                for _, stop := range bus {
                    if !visited[stop] {
                        visited[stop] = true
                        queue = append(queue, stop)
                    }
                }

                visited[busIdx] = true
            }
        }
        steps++
    }

    return -1
}