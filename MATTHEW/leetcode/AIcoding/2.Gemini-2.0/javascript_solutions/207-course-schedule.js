var canFinish = function(numCourses, prerequisites) {
    const adj = Array(numCourses).fill(null).map(() => []);
    const inDegree = Array(numCourses).fill(0);

    for (const [course, pre] of prerequisites) {
        adj[pre].push(course);
        inDegree[course]++;
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let count = 0;
    while (queue.length > 0) {
        const course = queue.shift();
        count++;

        for (const neighbor of adj[course]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return count === numCourses;
};