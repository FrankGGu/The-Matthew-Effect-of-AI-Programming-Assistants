var numJewelsInStones = function(jewels, stones) {
    let count = 0;
    const jewelSet = new Set(jewels);

    for (let i = 0; i < stones.length; i++) {
        if (jewelSet.has(stones[i])) {
            count++;
        }
    }

    return count;
};