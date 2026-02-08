var minDominoRotations = function(tops, bottoms) {
    const countA = new Array(7).fill(0);
    const countB = new Array(7).fill(0);
    const same = new Array(7).fill(0);

    for (let i = 0; i < tops.length; i++) {
        countA[tops[i]]++;
        countB[bottoms[i]]++;
        if (tops[i] === bottoms[i]) {
            same[tops[i]]++;
        }
    }

    for (let x = 1; x <= 6; x++) {
        if (countA[x] + countB[x] - same[x] >= tops.length) {
            return Math.min(countA[x], countB[x]) - same[x];
        }
    }

    return -1;
};