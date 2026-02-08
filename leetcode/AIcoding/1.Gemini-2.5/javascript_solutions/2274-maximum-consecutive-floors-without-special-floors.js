var maxConsecutive = function(bottom, top, special) {
    special.sort((a, b) => a - b);

    let maxConsec = 0;

    maxConsec = Math.max(maxConsec, special[0] - bottom);

    for (let i = 0; i < special.length - 1; i++) {
        maxConsec = Math.max(maxConsec, special[i+1] - special[i] - 1);
    }

    maxConsec = Math.max(maxConsec, top - special[special.length - 1]);

    return maxConsec;
};