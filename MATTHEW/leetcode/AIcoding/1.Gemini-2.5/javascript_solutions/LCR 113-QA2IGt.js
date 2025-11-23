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
        const u = queue[head++];
        result.push(u);

        for (const v of adj[u]) {
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    if (result.length === numCourses) {
        return result;
    } else {
        return [];
    }
};