var findOrder = function(numCourses, prerequisites) {
    const inDegree = new Array(numCourses).fill(0);
    const adj = new Array(numCourses).fill(null).map(() => []);

    for (const [course, pre] of prerequisites) {
        inDegree[course]++;
        adj[pre].push(course);
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (inDegree[i] === 0) {
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
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return count === numCourses ? result : [];
};