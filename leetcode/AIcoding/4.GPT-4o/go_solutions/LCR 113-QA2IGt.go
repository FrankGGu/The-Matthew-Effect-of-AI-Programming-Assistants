func findOrder(numCourses int, prerequisites [][]int) []int {
    graph := make([][]int, numCourses)
    indegree := make([]int, numCourses)

    for _, pre := range prerequisites {
        graph[pre[1]] = append(graph[pre[1]], pre[0])
        indegree[pre[0]]++
    }

    queue := []int{}
    for i := 0; i < numCourses; i++ {
        if indegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    order := []int{}
    for len(queue) > 0 {
        course := queue[0]
        queue = queue[1:]
        order = append(order, course)

        for _, next := range graph[course] {
            indegree[next]--
            if indegree[next] == 0 {
                queue = append(queue, next)
            }
        }
    }

    if len(order) == numCourses {
        return order
    }
    return []int{}
}