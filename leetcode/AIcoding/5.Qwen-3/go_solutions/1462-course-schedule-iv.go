package main

func courseScheduleIV(numCourses int, prerequisites [][]int, queries []int) []bool {
    graph := make([][]int, numCourses)
    inDegree := make([]int, numCourses)
    for _, pre := range prerequisites {
        graph[pre[1]] = append(graph[pre[1]], pre[0])
        inDegree[pre[0]]++
    }

    topoOrder := []int{}
    queue := []int{}
    for i := 0; i < numCourses; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        topoOrder = append(topoOrder, node)
        for _, neighbor := range graph[node] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    pos := make([]int, numCourses)
    for i, course := range topoOrder {
        pos[course] = i
    }

    result := make([]bool, len(queries))
    for i, query := range queries {
        course := query
        for j := 0; j < len(topoOrder); j++ {
            if topoOrder[j] == course {
                for k := j + 1; k < len(topoOrder); k++ {
                    if inDegree[topoOrder[k]] == 0 {
                        result[i] = true
                        break
                    }
                }
                break
            }
        }
    }

    return result
}