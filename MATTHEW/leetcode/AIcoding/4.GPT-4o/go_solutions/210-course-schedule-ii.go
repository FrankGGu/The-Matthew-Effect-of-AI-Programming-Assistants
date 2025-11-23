func findOrder(numCourses int, prerequisites [][]int) []int {
    indegree := make([]int, numCourses)
    graph := make([][]int, numCourses)

    for _, prereq := range prerequisites {
        graph[prereq[1]] = append(graph[prereq[1]], prereq[0])
        indegree[prereq[0]]++
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

        for _, nextCourse := range graph[course] {
            indegree[nextCourse]--
            if indegree[nextCourse] == 0 {
                queue = append(queue, nextCourse)
            }
        }
    }

    if len(order) == numCourses {
        return order
    }
    return []int{}
}