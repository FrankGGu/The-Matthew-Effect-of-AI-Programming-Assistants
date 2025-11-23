var maxCandies = function(candies, boxes) {
    const n = candies.length;
    const visited = new Array(n).fill(false);
    let totalCandies = 0;
    const queue = [];

    const bfs = (start) => {
        queue.push(start);
        visited[start] = true;

        while (queue.length) {
            const current = queue.shift();
            totalCandies += candies[current];

            for (const box of boxes[current]) {
                if (!visited[box]) {
                    visited[box] = true;
                    queue.push(box);
                }
            }
        }
    };

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            bfs(i);
        }
    }

    return totalCandies;
};