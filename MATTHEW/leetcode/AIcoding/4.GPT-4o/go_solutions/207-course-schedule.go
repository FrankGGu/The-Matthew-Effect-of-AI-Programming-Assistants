func canFinish(numCourses int, prerequisites [][]int) bool {
    indegree := make([]int, numCourses)
    graph := make([][]int, numCourses)

    for _, prereq := range prerequisites {
        graph[prereq[1]] = append(graph[prereq[1]], prereq[0])
        indegree[prereq[0]]++
    }

    queue := []int{}
    for i, deg := range indegree {
        if deg == 0 {
            queue = append(queue, i)
        }
    }

    count := 0
    for len(queue) > 0 {
        course := queue[0]
        queue = queue[1:]
        count++

        for _, nextCourse := range graph[course] {
            indegree[nextCourse]--
            if indegree[nextCourse] == 0 {
                queue = append(queue, nextCourse)
            }
        }
    }

    return count == numCourses
}