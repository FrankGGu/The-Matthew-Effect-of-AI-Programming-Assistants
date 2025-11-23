var kSimilarity = function(s1, s2) {
    if (s1 === s2) {
        return 0;
    }

    const n = s1.length;
    const queue = [[s1, 0]];
    const visited = new Set([s1]);
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const [current, index] = queue.shift();

            if (current === s2) {
                return steps;
            }

            let j = index;
            while (j < n && current[j] === s2[j]) {
                j++;
            }

            for (let k = j + 1; k < n; k++) {
                if (current[k] === s2[j] && current[k] !== s2[k]) {
                    const next = current.substring(0, j) + current[k] + current.substring(j + 1, k) + current[j] + current.substring(k + 1);
                    if (!visited.has(next)) {
                        queue.push([next, j + 1]);
                        visited.add(next);
                    }
                }
            }
        }
        steps++;
    }

    return -1;
};