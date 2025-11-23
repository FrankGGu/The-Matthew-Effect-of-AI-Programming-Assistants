var kSimilarity = function(s, t) {
    if (s === t) return 0;

    const queue = [[s, 0]];
    const visited = new Set();
    visited.add(s);

    while (queue.length > 0) {
        const [curr, steps] = queue.shift();

        if (curr === t) return steps;

        let i = 0;
        while (curr[i] === t[i]) i++;

        for (let j = i + 1; j < t.length; j++) {
            if (curr[j] === t[i] && curr[j] !== t[j]) {
                const next = curr.substring(0, i) + curr[j] + curr.substring(i + 1, j) + curr[i] + curr.substring(j + 1);

                if (!visited.has(next)) {
                    queue.push([next, steps + 1]);
                    visited.add(next);
                }
            }
        }
    }

    return -1;
};