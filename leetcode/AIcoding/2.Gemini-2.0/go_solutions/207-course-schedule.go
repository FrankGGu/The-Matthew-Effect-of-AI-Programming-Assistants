func canFinish(numCourses int, prerequisites [][]int) bool {
    graph := make([][]int, numCourses)
    inDegree := make([]int, numCourses)

    for _, pre := range prerequisites {
        course, prerequisite := pre[0], pre[1]
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
        course := queue[0]
        queue = queue[1:]
        count++

        for _, nextCourse := range graph[course] {
            inDegree[nextCourse]--
            if inDegree[nextCourse] == 0 {
                queue = append(queue, nextCourse)
            }
        }
    }

    return count == numCourses
}