package main

func maximumDetonations(bombs [][]int) int {
    n := len(bombs)
    maxDetonations := 0

    for i := 0; i < n; i++ {
        visited := make([]bool, n)
        queue := []int{i}
        visited[i] = true
        count := 0

        for len(queue) > 0 {
            current := queue[0]
            queue = queue[1:]
            count++

            for j := 0; j < n; j++ {
                if !visited[j] {
                    dx := bombs[current][0] - bombs[j][0]
                    dy := bombs[current][1] - bombs[j][1]
                    if dx*dx + dy*dy <= bombs[current][2]*bombs[current][2] {
                        visited[j] = true
                        queue = append(queue, j)
                    }
                }
            }
        }

        if count > maxDetonations {
            maxDetonations = count
        }
    }

    return maxDetonations
}