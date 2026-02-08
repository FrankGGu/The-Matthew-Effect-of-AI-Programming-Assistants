var minNumberOperations = function(target) {
    let operations = 0;
    let prevHeight = 0;

    for (let i = 0; i < target.length; i++) {
        if (target[i] > prevHeight) {
            operations += (target[i] - prevHeight);
        }
        prevHeight = target[i];
    }

    return operations;
};