var minimizeTheDifference = function(mat, target) {
    const m = mat.length, n = mat[0].length;
    const possibleSums = new Set([0]);

    for (let i = 0; i < m; i++) {
        const currentSums = new Set();
        for (let num of mat[i]) {
            for (let sum of possibleSums) {
                currentSums.add(sum + num);
            }
        }
        possibleSums = currentSums;
    }

    let closest = Infinity;
    for (let sum of possibleSums) {
        closest = Math.min(closest, Math.abs(sum - target));
    }

    return closest;
};