var findMaximizedCapital = function(k, w, profits, capital) {
    const n = profits.length;
    const projects = [];
    for (let i = 0; i < n; i++) {
        projects.push([capital[i], profits[i]]);
    }

    projects.sort((a, b) => a[0] - b[0]);

    let availableProjects = [];
    let projectIndex = 0;

    for (let i = 0; i < k; i++) {
        while (projectIndex < n && projects[projectIndex][0] <= w) {
            availableProjects.push(projects[projectIndex][1]);
            projectIndex++;
        }

        if (availableProjects.length === 0) {
            break;
        }

        availableProjects.sort((a, b) => b - a);
        w += availableProjects[0];
        availableProjects.shift();
    }

    return w;
};