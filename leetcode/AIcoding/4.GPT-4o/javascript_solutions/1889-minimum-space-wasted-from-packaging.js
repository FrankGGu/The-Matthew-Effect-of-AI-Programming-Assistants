var minWastedSpace = function(packages, boxes) {
    packages.sort((a, b) => a - b);
    let total = packages.reduce((a, b) => a + b, 0);
    let minWaste = Infinity;

    for (let box of boxes) {
        box.sort((a, b) => a - b);
        if (box[box.length - 1] < packages[packages.length - 1]) continue;

        let waste = 0, j = 0;
        for (let b of box) {
            let sum = 0;
            while (j < packages.length && sum + packages[j] <= b) {
                sum += packages[j];
                j++;
            }
            waste += b - sum;
        }
        minWaste = Math.min(minWaste, waste);
    }

    return minWaste === Infinity ? -1 : minWaste;
};