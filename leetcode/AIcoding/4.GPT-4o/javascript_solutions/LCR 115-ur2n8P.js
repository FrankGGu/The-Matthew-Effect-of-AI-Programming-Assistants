var sequenceReconstruction = function(org, seqs) {
    const graph = new Map();
    const indegree = new Map();
    const seen = new Set();

    for (const seq of seqs) {
        for (const num of seq) {
            if (!seen.has(num)) {
                seen.add(num);
                indegree.set(num, 0);
                graph.set(num, []);
            }
        }
    }

    for (const seq of seqs) {
        for (let i = 1; i < seq.length; i++) {
            const u = seq[i - 1];
            const v = seq[i];
            graph.get(u).push(v);
            indegree.set(v, indegree.get(v) + 1);
        }
    }

    if (seen.size !== org.length) return false;

    const queue = [];
    for (const num of org) {
        if (indegree.get(num) === 0) {
            queue.push(num);
        }
    }

    let index = 0;
    while (queue.length === 1) {
        const current = queue.shift();
        if (current !== org[index]) return false;
        index++;
        for (const neighbor of graph.get(current)) {
            indegree.set(neighbor, indegree.get(neighbor) - 1);
            if (indegree.get(neighbor) === 0) {
                queue.push(neighbor);
            }
        }
    }

    return index === org.length;
};