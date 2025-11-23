function findArrayGivenSubsetSums(subsetSums) {
    const n = subsetSums.length;
    const result = [];
    const freq = new Map();

    for (const sum of subsetSums) {
        freq.set(sum, (freq.get(sum) || 0) + 1);
    }

    const sorted = [...new Set(subsetSums)].sort((a, b) => a - b);
    const min = sorted[0];

    for (let i = 0; i < n; i++) {
        if (freq.get(min) > 0) {
            result.push(min);
            freq.set(min, freq.get(min) - 1);
            for (let j = 0; j < sorted.length; j++) {
                if (sorted[j] >= min) {
                    const key = sorted[j] - min;
                    if (freq.has(key)) {
                        freq.set(key, freq.get(key) - 1);
                        if (freq.get(key) === 0) {
                            freq.delete(key);
                        }
                    }
                }
            }
        } else {
            break;
        }
    }

    return result;
}