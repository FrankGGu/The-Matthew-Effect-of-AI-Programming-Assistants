var sequenceReconstruction = function(nums, sequences) {
    const n = nums.length;
    const adj = new Array(n + 1).fill(null).map(() => []);
    const indegree = new Array(n + 1).fill(0);
    const numSet = new Set(nums);

    for (const seq of sequences) {
        for (let i = 0; i < seq.length - 1; i++) {
            const u = seq[i];
            const v = seq[i + 1];

            if (!numSet.has(u) || !numSet.has(v)) return false;

            if (!adj[u].includes(v)) {
                adj[u].push(v);
                indegree[v]++;
            }
        }
    }

    const queue = [];
    for (let i = 1; i <= n; i++) {
        if (numSet.has(i) && indegree[i] === 0) {
            queue.push(i);
        }
    }

    let count = 0;
    let reconstructed = [];

    while (queue.length > 0) {
        if (queue.length > 1) return false;

        const u = queue.shift();
        reconstructed.push(u);
        count++;

        for (const v of adj[u]) {
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return count === n && nums.every((val, index) => val === reconstructed[index]);
};