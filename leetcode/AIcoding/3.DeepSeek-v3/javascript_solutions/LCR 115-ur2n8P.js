var sequenceReconstruction = function(nums, sequences) {
    const n = nums.length;
    const graph = new Array(n + 1).fill().map(() => []);
    const inDegree = new Array(n + 1).fill(0);

    for (const seq of sequences) {
        for (let i = 0; i < seq.length - 1; i++) {
            const u = seq[i];
            const v = seq[i + 1];
            graph[u].push(v);
            inDegree[v]++;
        }
    }

    const queue = [];
    for (let i = 1; i <= n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
    }

    let index = 0;
    while (queue.length > 0) {
        if (queue.length > 1) {
            return false;
        }
        const u = queue.shift();
        if (u !== nums[index++]) {
            return false;
        }
        for (const v of graph[u]) {
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return index === n;
};