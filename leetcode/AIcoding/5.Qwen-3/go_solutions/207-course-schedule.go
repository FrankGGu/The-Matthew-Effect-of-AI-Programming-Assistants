package main

func canFinish(numCourses int, prerequisites [][]int) bool {
    inDegree := make([]int, numCourses)
    graph := make([][]int, numCourses)

    for _, pre := range prerequisites {
        course := pre[0]
        prerequisite := pre[1]
        graph[prerequisite] = append(graph[prerequisite], course)
        inDegree[course]++
    }

    queue := []int{}
    for i := 0; i < numCourses; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    count := 0
    for len(queue) > 0 {
        current := queue[0]
        queue = queue[1:]
        count++
        for _, neighbor := range graph[current] {
            inDegree[neighbor]--
            if inDegree[neighbor] == 0 {
                queue = append(queue, neighbor)
            }
        }
    }

    return count == numCourses
}