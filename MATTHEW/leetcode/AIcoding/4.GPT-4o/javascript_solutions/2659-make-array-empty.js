var makeArrayEmpty = function(target) {
    let operations = 0;
    const maxElement = Math.max(...target);
    const counts = new Array(maxElement + 1).fill(0);

    for (const num of target) {
        counts[num]++;
    }

    for (let i = 1; i <= maxElement; i++) {
        if (counts[i] > 0) {
            operations += counts[i] * 2 - 1;
        }
    }

    return operations;
};