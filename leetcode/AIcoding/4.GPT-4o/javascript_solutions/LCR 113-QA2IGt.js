var findOrder = function(numCourses, prerequisites) {
    const adjList = new Array(numCourses).fill(0).map(() => []);
    const indegree = new Array(numCourses).fill(0);

    for (const [course, prereq] of prerequisites) {
        adjList[prereq].push(course);
        indegree[course]++;
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (indegree[i] === 0) queue.push(i);
    }

    const order = [];
    while (queue.length > 0) {
        const course = queue.shift();
        order.push(course);

        for (const nextCourse of adjList[course]) {
            indegree[nextCourse]--;
            if (indegree[nextCourse] === 0) {
                queue.push(nextCourse);
            }
        }
    }

    return order.length === numCourses ? order : [];
};