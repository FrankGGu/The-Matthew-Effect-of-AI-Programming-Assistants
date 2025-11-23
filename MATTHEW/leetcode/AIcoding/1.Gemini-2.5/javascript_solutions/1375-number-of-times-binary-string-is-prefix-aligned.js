var numTimesAllBlue = function(perm) {
    let count = 0;
    let currentMax = 0;

    for (let i = 0; i < perm.length; i++) {
        currentMax = Math.max(currentMax, perm[i]);
        if (currentMax === i + 1) {
            count++;
        }
    }

    return count;
};