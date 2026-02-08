var maximumScore = function(a, b, c) {
    let stones = [a, b, c];
    let score = 0;

    while (true) {
        stones.sort((x, y) => y - x);
        if (stones[1] === 0) break;
        score += 1;
        stones[0] -= 1;
        stones[1] -= 1;
    }

    return score;
};