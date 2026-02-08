var canCross = function(stones) {
    const n = stones.length;
    const dp = new Map();

    const jump = (index, jumpSize) => {
        if (index === n - 1) return true;
        const key = `${index},${jumpSize}`;
        if (dp.has(key)) return dp.get(key);

        for (let k = jumpSize - 1; k <= jumpSize + 1; k++) {
            if (k > 0) {
                const nextStone = stones[index] + k;
                const nextIndex = stones.indexOf(nextStone);
                if (nextIndex > index && jump(nextIndex, k)) {
                    dp.set(key, true);
                    return true;
                }
            }
        }

        dp.set(key, false);
        return false;
    };

    return jump(0, 0);
};