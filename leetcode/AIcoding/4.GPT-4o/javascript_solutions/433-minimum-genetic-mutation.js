var minMutation = function(start, end, bank) {
    const geneSet = new Set(bank);
    if (!geneSet.has(end)) return -1;

    const genes = ['A', 'C', 'G', 'T'];
    let queue = [[start, 0]];
    let visited = new Set([start]);

    while (queue.length > 0) {
        const [current, mutations] = queue.shift();
        if (current === end) return mutations;

        for (let i = 0; i < current.length; i++) {
            for (const gene of genes) {
                if (gene !== current[i]) {
                    const next = current.slice(0, i) + gene + current.slice(i + 1);
                    if (geneSet.has(next) && !visited.has(next)) {
                        visited.add(next);
                        queue.push([next, mutations + 1]);
                    }
                }
            }
        }
    }
    return -1;
};