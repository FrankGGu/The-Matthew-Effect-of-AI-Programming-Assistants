var minMutation = function(start, end, bank) {
    const bankSet = new Set(bank);
    if (!bankSet.has(end)) {
        return -1;
    }

    const queue = [[start, 0]];
    const visited = new Set();
    visited.add(start);

    const geneChars = ['A', 'C', 'G', 'T'];

    while (queue.length > 0) {
        const [currentGene, mutations] = queue.shift();

        if (currentGene === end) {
            return mutations;
        }

        for (let i = 0; i < currentGene.length; i++) {
            for (const char of geneChars) {
                if (currentGene[i] === char) {
                    continue;
                }
                const nextGeneArr = currentGene.split('');
                nextGeneArr[i] = char;
                const nextGene = nextGeneArr.join('');

                if (bankSet.has(nextGene) && !visited.has(nextGene)) {
                    visited.add(nextGene);
                    queue.push([nextGene, mutations + 1]);
                }
            }
        }
    }

    return -1;
};