function findMaximizedCapital(k, w, profits, capital) {
    const projects = profits.map((p, i) => [capital[i], p]);
    projects.sort((a, b) => a[0] - b[0]);

    const maxHeap = [];

    let i = 0;
    for (let j = 0; j < k; j++) {
        while (i < projects.length && projects[i][0] <= w) {
            maxHeap.push(projects[i][1]);
            i++;
        }

        if (maxHeap.length === 0) break;

        maxHeap.sort((a, b) => b - a);
        w += maxHeap.shift();
    }

    return w;
}