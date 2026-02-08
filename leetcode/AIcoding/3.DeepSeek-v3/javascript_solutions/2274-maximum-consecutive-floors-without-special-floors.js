var maxConsecutive = function(bottom, top, special) {
    special.sort((a, b) => a - b);
    let max = 0;
    max = Math.max(max, special[0] - bottom);
    for (let i = 1; i < special.length; i++) {
        max = Math.max(max, special[i] - special[i - 1] - 1);
    }
    max = Math.max(max, top - special[special.length - 1]);
    return max;
};