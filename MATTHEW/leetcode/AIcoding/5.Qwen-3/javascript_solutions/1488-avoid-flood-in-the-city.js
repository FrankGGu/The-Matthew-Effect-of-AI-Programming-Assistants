function avoidFlood(rains) {
    const n = rains.length;
    const result = new Array(n).fill(1);
    const lastRain = new Map();
    const sorted = [];

    for (let i = 0; i < n; i++) {
        if (rains[i] === 0) {
            sorted.push(i);
        } else {
            if (lastRain.has(rains[i])) {
                const prev = lastRain.get(rains[i]);
                let j = 0;
                while (j < sorted.length && sorted[j] < prev) {
                    j++;
                }
                if (j < sorted.length) {
                    result[sorted[j]] = rains[i];
                    sorted.splice(j, 1);
                } else {
                    return [];
                }
            }
            lastRain.set(rains[i], i);
            result[i] = 1;
        }
    }

    for (const idx of sorted) {
        result[idx] = 1;
    }

    return result;
}