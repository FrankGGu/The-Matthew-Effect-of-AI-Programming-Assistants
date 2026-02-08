var findOrder = function(numCourses, prerequisites) {
    const graph = new Array(numCourses).fill(0).map(() => []);
    const inDegree = new Array(numCourses).fill(0);
    const result = [];

    for (const [course, prereq] of prerequisites) {
        graph[prereq].push(course);
        inDegree[course]++;
    }

    const queue = [];
    for (let i = 0; i < numCourses; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let count = 0;
    while (queue.length) {
        const current = queue.shift();
        result.push(current);
        count++;

        for (const neighbor of graph[current]) {
            inDegree[neighbor]--;
            if (inDegree[neighbor] === 0) {
                queue.push(neighbor);
            }
        }
    }

    return count === numCourses ? result : [];
};