var minMutation = function(start, end, bank) {
    const queue = [start];
    const visited = new Set([start]);
    const mutations = ['A', 'C', 'G', 'T'];
    let steps = 0;

    while (queue.length > 0) {
        const levelSize = queue.length;

        for (let i = 0; i < levelSize; i++) {
            const current = queue.shift();

            if (current === end) {
                return steps;
            }

            for (const char of mutations) {
                for (let j = 0; j < current.length; j++) {
                    if (current[j] !== char) {
                        const next = current.substring(0, j) + char + current.substring(j + 1);

                        if (bank.includes(next) && !visited.has(next)) {
                            visited.add(next);
                            queue.push(next);
                        }
                    }
                }
            }
        }

        steps++;
    }

    return -1;
};