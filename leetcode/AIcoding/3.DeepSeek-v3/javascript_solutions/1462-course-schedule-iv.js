var checkIfPrerequisite = function(numCourses, prerequisites, queries) {
    const graph = Array.from({ length: numCourses }, () => new Set());
    const reachable = Array.from({ length: numCourses }, () => new Array(numCourses).fill(false));

    for (const [u, v] of prerequisites) {
        graph[u].add(v);
        reachable[u][v] = true;
    }

    for (let k = 0; k < numCourses; k++) {
        for (let i = 0; i < numCourses; i++) {
            for (let j = 0; j < numCourses; j++) {
                if (reachable[i][k] && reachable[k][j]) {
                    reachable[i][j] = true;
                }
            }
        }
    }

    const result = [];
    for (const [u, v] of queries) {
        result.push(reachable[u][v]);
    }
    return result;
};