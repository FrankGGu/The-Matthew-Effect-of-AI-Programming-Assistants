var canCross = function(stones) {
    const dp = new Map();

    for (const stone of stones) {
        dp.set(stone, new Set());
    }

    dp.get(0).add(0);

    for (const currentStone of stones) {
        for (const k of dp.get(currentStone)) {
            for (const nextK of [k - 1, k, k + 1]) {
                if (nextK > 0) {
                    const nextStonePos = currentStone + nextK;
                    if (dp.has(nextStonePos)) {
                        dp.get(nextStonePos).add(nextK);
                    }
                }
            }
        }
    }

    return dp.get(stones[stones.length - 1]).size > 0;
};