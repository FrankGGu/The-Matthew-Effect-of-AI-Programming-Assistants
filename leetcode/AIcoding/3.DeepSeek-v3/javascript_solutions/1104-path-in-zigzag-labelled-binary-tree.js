var pathInZigZagTree = function(label) {
    let level = 0;
    while (Math.pow(2, level) <= label) {
        level++;
    }

    let res = [];
    while (label >= 1) {
        res.unshift(label);
        let max = Math.pow(2, level) - 1;
        let min = Math.pow(2, level - 1);
        label = Math.floor((max + min - label) / 2);
        level--;
    }
    return res;
};