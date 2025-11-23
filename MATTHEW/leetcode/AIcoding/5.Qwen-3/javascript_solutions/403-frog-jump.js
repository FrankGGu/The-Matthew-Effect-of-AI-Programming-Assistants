function canCross(stones) {
    const map = new Map();
    for (let i = 0; i < stones.length; i++) {
        map.set(stones[i], new Set());
    }
    map.get(0).add(0);
    for (let i = 0; i < stones.length; i++) {
        const position = stones[i];
        const jumps = map.get(position);
        for (const jump of jumps) {
            for (let k = 1; k <= 2; k++) {
                const nextPosition = position + jump + k - 1;
                if (map.has(nextPosition)) {
                    map.get(nextPosition).add(jump + k);
                }
            }
        }
    }
    return map.get(stones[stones.length - 1]).size > 0;
}