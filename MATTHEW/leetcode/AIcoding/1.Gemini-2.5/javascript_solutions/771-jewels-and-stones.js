var numJewelsInStones = function(jewels, stones) {
    const jewelSet = new Set();
    for (let i = 0; i < jewels.length; i++) {
        jewelSet.add(jewels[i]);
    }

    let count = 0;
    for (let i = 0; i < stones.length; i++) {
        if (jewelSet.has(stones[i])) {
            count++;
        }
    }

    return count;
};