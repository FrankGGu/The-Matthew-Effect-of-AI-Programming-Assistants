var kSimilarity = function(s1, s2) {
    const queue = [[s1, 0]];
    const visited = new Set([s1]);

    while (queue.length > 0) {
        const [current, k] = queue.shift();
        if (current === s2) {
            return k;
        }
        let i = 0;
        while (i < current.length && current[i] === s2[i]) {
            i++;
        }
        for (let j = i + 1; j < current.length; j++) {
            if (current[j] === s2[i] && current[j] !== s2[j]) {
                const next = swap(current, i, j);
                if (!visited.has(next)) {
                    visited.add(next);
                    queue.push([next, k + 1]);
                }
            }
        }
    }
    return -1;
};

function swap(s, i, j) {
    const arr = s.split('');
    [arr[i], arr[j]] = [arr[j], arr[i]];
    return arr.join('');
}