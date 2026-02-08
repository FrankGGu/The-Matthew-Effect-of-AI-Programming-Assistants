package main

func shortestAlternatingPaths(n int, redEdges [][]int, blueEdges [][]int) []int {
    fromRed := make(map[int][]int)
    fromBlue := make(map[int][]int)

    for _, edge := range redEdges {
        fromRed[edge[0]] = append(fromRed[edge[0]], edge[1])
    }

    for _, edge := range blueEdges {
        fromBlue[edge[0]] = append(fromBlue[edge[0]], edge[1])
    }

    type state struct {
        node, color int
    }

    visited := make(map[state]bool)
    queue := []state{{0, 0}}
    visited[state{0, 0}] = true

    result := make([]int, n)
    for i := range result {
        result[i] = -1
    }
    result[0] = 0

    step := 0

    for len(queue) > 0 {
        for size := len(queue); size > 0; size-- {
            current := queue[0]
            queue = queue[1:]

            if result[current.node] == -1 {
                result[current.node] = step
            }

            nextColor := 1 - current.color
            if current.color == 0 {
                for _, neighbor := range fromBlue[current.node] {
                    s := state{neighbor, nextColor}
                    if !visited[s] {
                        visited[s] = true
                        queue = append(queue, s)
                    }
                }
            } else {
                for _, neighbor := range fromRed[current.node] {
                    s := state{neighbor, nextColor}
                    if !visited[s] {
                        visited[s] = true
                        queue = append(queue, s)
                    }
                }
            }
        }
        step++
    }

    return result
}