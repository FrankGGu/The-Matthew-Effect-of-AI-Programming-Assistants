function minSwapsCouples(pairs) {
    const n = pairs.length;
    const pos = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        pos[pairs[i]] = i;
    }

    let swaps = 0;
    for (let i = 0; i < n; i += 2) {
        const x = pairs[i];
        const y = x ^ 1;
        if (pairs[i + 1] === y) continue;
        const j = pos[y];
        pos[pairs[i + 1]] = j;
        pos[y] = i + 1;
        [pairs[i + 1], pairs[j]] = [pairs[j], pairs[i + 1]];
        swaps++;
    }
    return swaps;
}