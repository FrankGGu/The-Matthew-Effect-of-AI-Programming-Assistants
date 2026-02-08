var maximumScore = function(a, b, c) {
    let piles = [a, b, c];
    piles.sort((x, y) => x - y);

    let p1 = piles[0];
    let p2 = piles[1];
    let p3 = piles[2];

    if (p3 > p1 + p2) {
        return p1 + p2;
    } else {
        return Math.floor((p1 + p2 + p3) / 2);
    }
};