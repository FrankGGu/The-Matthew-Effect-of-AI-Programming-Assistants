var pathInZigZagTree = function(label) {
    let level = 0;
    let temp = label;
    while (temp > 0) {
        level++;
        temp = Math.floor(temp / 2);
    }

    const path = [];
    let current = label;

    while (level > 0) {
        path.unshift(current);
        if (level > 1) {
            const min = Math.pow(2, level - 1);
            const max = Math.pow(2, level) - 1;
            const parent = Math.floor(current / 2);
            current = min + max - parent;
        }
        level--;
    }

    return path;
};