var minimumOperations = function(colors) {
    let n = colors.length;
    let count = Array(5).fill(0);
    for (let color of colors) {
        count[color]++;
    }

    let maxCount = Math.max(...count);
    let mostColor = count.indexOf(maxCount);
    let operations = n - maxCount;

    for (let i = 1; i <= 4; i++) {
        if (i !== mostColor) {
            operations -= Math.min(count[i], maxCount);
        }
    }

    return operations;
};