function minKTranspositions(s1, s2) {
    const n = s1.length;
    const target = s2;
    const queue = [s1];
    const visited = new Set([s1]);
    const map = new Map();

    for (let i = 0; i < n; i++) {
        map.set(s1[i], (map.get(s1[i]) || 0) + 1);
    }

    for (let i = 0; i < n; i++) {
        map.set(s2[i], (map.get(s2[i]) || 0) - 1);
    }

    for (let key of map.keys()) {
        if (map.get(key) !== 0) return -1;
    }

    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            if (current === target) return steps;
            for (let j = 0; j < n; j++) {
                if (current[j] === target[j]) continue;
                for (let k = j + 1; k < n; k++) {
                    if (current[k] === target[j] && current[k] !== target[k]) {
                        const arr = current.split('');
                        [arr[j], arr[k]] = [arr[k], arr[j]];
                        const next = arr.join('');
                        if (!visited.has(next)) {
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
}