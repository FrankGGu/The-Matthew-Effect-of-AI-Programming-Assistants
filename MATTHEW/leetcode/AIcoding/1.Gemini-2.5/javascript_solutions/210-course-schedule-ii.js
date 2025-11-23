var findOrder = function(numCourses, prerequisites) {
    const adj = new Array(numCourses).fill(0).map(() => []);
    const inDegree = new Array(numCourses).fill(0);

    for (const [course, prereq] of prerequisites) {
        adj[prereq].push(course);
        inDegree[course]++;
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    const result = [];
    let head = 0;
    while (head < queue.length) {
        const course = queue[head++];
        result.push(course);

        for (const neighbor of adj[course]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    if (result.length === numCourses) {
        return result;
    } else {
        return [];
    }
};