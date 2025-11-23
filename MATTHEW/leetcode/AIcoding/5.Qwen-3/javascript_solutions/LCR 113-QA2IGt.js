function findOrder(numCourses, prerequisites) {
    const graph = new Array(numCourses).fill(0).map(() => []);
    const inDegree = new Array(numCourses).fill(0);

    for (const [course, pre] of prerequisites) {
        graph[pre].push(course);
        inDegree[course]++;
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    const result = [];
    while (queue.length > 0) {
        const course = queue.shift();
        result.push(course);
        for (const next of graph[course]) {
            inDegree[next]--;
            if (inDegree[next] === 0) {
                queue.push(next);
            }
        }
    }

    return result.length === numCourses ? result : [];
}