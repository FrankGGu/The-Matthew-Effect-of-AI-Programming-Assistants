var minMutation = function(start, end, bank) {
    const bankSet = new Set(bank);
    if (!bankSet.has(end)) return -1;

    const queue = [[start, 0]];
    const visited = new Set();
    visited.add(start);
    const chars = ['A', 'C', 'G', 'T'];

    while (queue.length > 0) {
        const [current, mutations] = queue.shift();
        if (current === end) return mutations;

        for (let i = 0; i < current.length; i++) {
            for (const char of chars) {
                if (char === current[i]) continue;
                const newGene = current.substring(0, i) + char + current.substring(i + 1);
                if (bankSet.has(newGene) && !visited.has(newGene)) {
                    visited.add(newGene);
                    queue.push([newGene, mutations + 1]);
                }
            }
        }
    }

    return -1;
};