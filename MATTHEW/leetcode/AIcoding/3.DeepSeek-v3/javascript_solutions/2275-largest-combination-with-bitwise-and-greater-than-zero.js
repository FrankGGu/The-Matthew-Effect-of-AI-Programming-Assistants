var largestCombination = function(candidates) {
    let max = 0;
    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (let num of candidates) {
            if ((num >> i) & 1) {
                count++;
            }
        }
        max = Math.max(max, count);
    }
    return max;
};