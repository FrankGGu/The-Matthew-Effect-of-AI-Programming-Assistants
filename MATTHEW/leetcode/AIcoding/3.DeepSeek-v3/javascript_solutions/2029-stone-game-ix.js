var stoneGameIX = function(stones) {
    let count = [0, 0, 0];
    for (let stone of stones) {
        count[stone % 3]++;
    }

    if (count[0] % 2 === 0) {
        return count[1] > 0 && count[2] > 0;
    } else {
        return Math.abs(count[1] - count[2]) > 2;
    }
};