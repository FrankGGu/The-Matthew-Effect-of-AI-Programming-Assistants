var minMutation = function(startGene, endGene, bank) {
    const queue = [[startGene, 0]];
    const visited = new Set();
    visited.add(startGene);
    const mutations = ['A', 'C', 'G', 'T'];

    while (queue.length > 0) {
        const [currentGene, steps] = queue.shift();

        if (currentGene === endGene) {
            return steps;
        }

        for (let i = 0; i < currentGene.length; i++) {
            for (const mutation of mutations) {
                const nextGene = currentGene.substring(0, i) + mutation + currentGene.substring(i + 1);

                if (bank.includes(nextGene) && !visited.has(nextGene)) {
                    queue.push([nextGene, steps + 1]);
                    visited.add(nextGene);
                }
            }
        }
    }

    return -1;
};