var supplyWagon = function(supplies) {
    let n = supplies.length;
    let target = n / 2;
    while (supplies.length > target) {
        let minSum = Infinity;
        let mergeIndex = 0;
        for (let i = 0; i < supplies.length - 1; i++) {
            let sum = supplies[i] + supplies[i + 1];
            if (sum < minSum) {
                minSum = sum;
                mergeIndex = i;
            }
        }
        supplies.splice(mergeIndex, 2, minSum);
    }
    return supplies;
};