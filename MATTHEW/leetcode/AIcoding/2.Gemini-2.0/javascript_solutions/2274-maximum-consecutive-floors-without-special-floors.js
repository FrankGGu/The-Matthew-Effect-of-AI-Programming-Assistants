var maxConsecutive = function(bottom, top, special) {
    special.sort((a, b) => a - b);
    let max = Math.max(special[0] - bottom, top - special[special.length - 1]);
    for (let i = 1; i < special.length; i++) {
        max = Math.max(max, special[i] - special[i - 1] - 1);
    }
    return max;
};