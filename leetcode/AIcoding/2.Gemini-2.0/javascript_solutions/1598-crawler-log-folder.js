var minOperations = function(logs) {
    let depth = 0;
    for (let log of logs) {
        if (log === "../") {
            depth = Math.max(0, depth - 1);
        } else if (log === "./") {
            continue;
        } else {
            depth++;
        }
    }
    return depth;
};