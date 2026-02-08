var minCost = function(basket1, basket2) {
    const freq = new Map();
    for (const fruit of basket1) {
        freq.set(fruit, (freq.get(fruit) || 0) + 1);
    }
    for (const fruit of basket2) {
        freq.set(fruit, (freq.get(fruit) || 0) - 1);
    }

    const swaps = [];
    let minFruit = Infinity;
    for (const [fruit, count] of freq) {
        if (count % 2 !== 0) return -1;
        const swapsNeeded = Math.abs(count) / 2;
        for (let i = 0; i < swapsNeeded; i++) {
            swaps.push(fruit);
        }
        minFruit = Math.min(minFruit, fruit);
    }

    swaps.sort((a, b) => a - b);
    let res = 0;
    const n = swaps.length;
    for (let i = 0; i < n / 2; i++) {
        res += Math.min(swaps[i], 2 * minFruit);
    }
    return res;
};