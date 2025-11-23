var findOrder = function(numCourses, prerequisites) {
    const adj = Array(numCourses).fill(null).map(() => []);
    const indegree = Array(numCourses).fill(0);

    for (const [course, pre] of prerequisites) {
        adj[pre].push(course);
        indegree[course]++;
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
        }
    }

    const result = [];
    let count = 0;

    while (queue.length > 0) {
        const course = queue.shift();
        result.push(course);
        count++;

        for (const neighbor of adj[course]) {
            indegree[neighbor]--;
            if (indegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return count === numCourses ? result : [];
};