func findOrder(numCourses int, prerequisites [][]int) []int {
    inDegree := make([]int, numCourses)
    adj := make([][]int, numCourses)

    for _, p := range prerequisites {
        inDegree[p[0]]++
        adj[p[1]] = append(adj[p[1]], p[0])
    }

    queue := []int{}
    for i := 0; i < numCourses; i++ {
        if inDegree[i] == 0 {
            queue = append(queue, i)
        }
    }

    count := 0
    result := []int{}

    for len(queue) > 0 {
        course := queue[0]
        queue = queue[1:]
        result = append(result, course)
        count++

        for _, nextCourse := range adj[course] {
            inDegree[nextCourse]--
            if inDegree[nextCourse] == 0 {
                queue = append(queue, nextCourse)
            }
        }
    }

    if count == numCourses {
        return result
    }

    return []int{}
}