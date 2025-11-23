var kSimilarity = function(A, B) {
    const n = A.length;
    const queue = [[A, 0]];
    const visited = new Set([A]);

    const swap = (s, i, j) => {
        const arr = s.split('');
        [arr[i], arr[j]] = [arr[j], arr[i]];
        return arr.join('');
    };

    while (queue.length) {
        const [cur, step] = queue.shift();
        if (cur === B) return step;

        let i = 0;
        while (cur[i] === B[i]) i++;

        for (let j = i + 1; j < n; j++) {
            if (cur[j] === B[i]) {
                const next = swap(cur, i, j);
                if (!visited.has(next)) {
                    visited.add(next);
                    queue.push([next, step + 1]);
                }
            }
        }
    }

    return -1;
};