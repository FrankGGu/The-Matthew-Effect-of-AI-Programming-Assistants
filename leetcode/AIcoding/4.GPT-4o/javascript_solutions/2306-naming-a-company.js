var distinctNames = function(ideas) {
    const set = new Set(ideas);
    let count = 0;
    const prefixMap = new Map();

    for (const idea of ideas) {
        const prefix = idea[0];
        const suffix = idea.slice(1);
        if (!prefixMap.has(suffix)) {
            prefixMap.set(suffix, new Set());
        }
        prefixMap.get(suffix).add(prefix);
    }

    const suffixes = Array.from(prefixMap.keys());

    for (let i = 0; i < suffixes.length; i++) {
        for (let j = i + 1; j < suffixes.length; j++) {
            const countA = prefixMap.get(suffixes[i]).size;
            const countB = prefixMap.get(suffixes[j]).size;
            count += countA * countB * 2; // (A, B) and (B, A)
        }
    }

    return count;
};