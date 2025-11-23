var stoneGameIX = function(stones) {
    let count = [0, 0, 0];
    for (let stone of stones) {
        count[stone % 3]++;
    }

    const [c0, c1, c2] = count;

    if (c1 === 0 && c2 === 0) return false;
    if (c1 === 0) return c2 % 3 === 0;
    if (c2 === 0) return c1 % 3 === 0;

    return c0 % 2 === 1 || c1 > c2;
};