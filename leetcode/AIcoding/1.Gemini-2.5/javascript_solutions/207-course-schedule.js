var canFinish = function(numCourses, prerequisites) {
    const adj = new Array(numCourses).fill(0).map(() => []);
    const visited = new Array(numCourses).fill(0); // 0: unvisited, 1: visiting, 2: visited

    for (const [course, prereq] of prerequisites) {
        adj[prereq].push(course);
    }

    function dfs(course) {
        if (visited[course] === 1) {
            return false;
        }
        if (visited[course] === 2) {
            return true;
        }

        visited[course] = 1;

        for (const neighbor of adj[course]) {
            if (!dfs(neighbor)) {
                return false;
            }
        }

        visited[course] = 2;
        return true;
    }

    for (let i = 0; i < numCourses; i++) {
        if (visited[i] === 0) {
            if (!dfs(i)) {
                return false;
            }
        }
    }

    return true;
};