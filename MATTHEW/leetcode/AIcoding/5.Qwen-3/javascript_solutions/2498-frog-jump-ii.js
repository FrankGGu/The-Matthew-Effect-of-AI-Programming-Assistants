function canCross(stones) {
    if (stones[0] !== 0) return false;
    const map = new Map();
    for (let i = 0; i < stones.length; i++) {
        map.set(stones[i], new Set());
    }
    map.get(0).add(0);
    for (let i = 0; i < stones.length; i++) {
        const stone = stones[i];
        const jumps = map.get(stone);
        for (const jump of jumps) {
            for (let k = 1; k <= 2; k++) {
                const next = stone + jump + k - 1;
                if (map.has(next) && next >= stone) {
                    map.get(next).add(jump + k - 1);
                }
            }
        }
    }
    return map.get(stones[stones.length - 1]).size > 0;
}