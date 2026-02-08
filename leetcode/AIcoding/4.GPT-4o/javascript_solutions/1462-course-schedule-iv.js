class CourseScheduler {
    constructor(numCourses, prerequisites) {
        this.adjList = new Map();
        this.indegree = Array(numCourses).fill(0);
        this.buildGraph(prerequisites);
    }

    buildGraph(prerequisites) {
        for (const [course, prereq] of prerequisites) {
            if (!this.adjList.has(prereq)) {
                this.adjList.set(prereq, []);
            }
            this.adjList.get(prereq).push(course);
            this.indegree[course]++;
        }
    }

    canFinish(course) {
        const visited = new Set();
        const path = new Set();
        return this.dfs(course, visited, path);
    }

    dfs(course, visited, path) {
        if (path.has(course)) return false;
        if (visited.has(course)) return true;

        path.add(course);
        visited.add(course);

        if (this.adjList.has(course)) {
            for (const neighbor of this.adjList.get(course)) {
                if (!this.dfs(neighbor, visited, path)) {
                    return false;
                }
            }
        }

        path.delete(course);
        return true;
    }
}

var canFinishCourses = function(numCourses, prerequisites, queries) {
    const scheduler = new CourseScheduler(numCourses, prerequisites);
    const results = [];

    for (const [course, prereq] of queries) {
        results.push(scheduler.canFinish(prereq));
    }

    return results;
};